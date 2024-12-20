from django.shortcuts import render
from rest_framework.decorators import api_view
from django.http import JsonResponse
from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
from rest_framework.parsers import JSONParser
from asgiref.sync import sync_to_async
from .models import Prediction
from .serializers import PredictionSerializer
import websockets
import asyncio
import json
import threading
from rest_framework.views import APIView
from rest_framework.response import Response
# from pymongo import MongoClient
from Prediction.shubh import *
from Prediction.shivansh import *
import csv
from rest_framework import status
from django.contrib.auth.hashers import check_password
from .models import Employee
from .serializers import EmployeeLoginSerializer
import logging
from pymongo import MongoClient
from rest_framework.response import Response
from rest_framework import status
from .models import Prediction
from django.db.models import Q
from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
import json
from Prediction.suggestion import *

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger("websocket_server")
# Global variables to track WebSocket server and connections
# message_queue = asyncio.Queue()
# class FetchMongoDataView(APIView):
#     def get(self, request, *args, **kwargs):
#         # Replace with your actual connection string
#         connection_string = "mongodb+srv://betelgeuse715:mBgMGu1VTQgBGu7d@gaurav.pvw5o.mongodb.net/?retryWrites=true&w=majority&appName=GAURAV"

#         # Connect to MongoDB
#         client = MongoClient(connection_string)
#         db = client['TEST']
#         collection = db['SIH']

#         try:
#             # Fetch all documents from the collection
#             data = list(collection.find({}, {'_id': 0}))  # Exclude '_id' field for simplicity
#             return Response({"data": data}, status=200)
#         except Exception as e:
#             return Response({"error": str(e)}, status=500)
#         finally:
#             # Close the connection
#             client.close()

# @api_view(['POST'])
# def reverse_predict_api(request):
#     result = reverse_predict(request.data)
#     if isinstance(result, str):
#         try:
#             result = json.loads(result)  # Convert JSON string to dictionary
#         except json.JSONDecodeError:
#             return Response({"error": "Invalid JSON format returned from reverse_predict"}, status=400)
#     return Response(result)

async def ws_client(data):
    """Send data to the WebSocket server."""
    uri = "ws://localhost:7890"
    try:
        async with websockets.connect(uri) as websocket:
            if not isinstance(data, dict):
                logger.error("Invalid input: Data must be a dictionary.")
                return
            await websocket.send(json.dumps(data))
            logger.info("Sent to server: %s", data)
    except Exception as e:
        logger.error("Failed to connect to WebSocket server: %s", e)

@api_view(['POST'])
def reverse_predict_api(request):
    input_data= request.data
    UTS = request.data.get("UTS")
    Elongation = request.data.get("Elongation")
    Conductivity = request.data.get("Conductivity")

    # Ensure all values are provided
    if None in (UTS, Elongation, Conductivity):
        return Response({"error": "All three values (UTS, Elongation, Conductivity) are required."}, status=400)

    # Create a dictionary of inputs
    input_data = {
        "UTS": UTS,
        "Elongation": Elongation,
        "Conductivity": Conductivity
    }

    # Pass the dictionary to reverse_predict
    try:
        result = reverse_predict(input_data)  # Single argument
        
        if isinstance(result, str):
            try:
                result = json.loads(result)  # Assuming result is a JSON string
            except json.JSONDecodeError:
                return Response({"error": "Invalid JSON format returned from reverse_predict"}, status=400)

        # Save the result to the database (Prediction model)
        prediction = Prediction(
            EMUL_OIL_L_TEMP_PV_VAL0=result.get('EMUL_OIL_L_TEMP_PV_VAL0', 0),
            STAND_OIL_L_TEMP_PV_REAL_VAL0=result.get('STAND_OIL_L_TEMP_PV_REAL_VAL0', 0),
            GEAR_OIL_L_TEMP_PV_REAL_VAL0=result.get('GEAR_OIL_L_TEMP_PV_REAL_VAL0', 0),
            EMUL_OIL_L_PR_VAL0=result.get('EMUL_OIL_L_PR_VAL0', 0),
            QUENCH_CW_FLOW_EXIT_VAL0=result.get('QUENCH_CW_FLOW_EXIT_VAL0', 0),
            CAST_WHEEL_RPM_VAL0=result.get('CAST_WHEEL_RPM_VAL0', 0),
            BAR_TEMP_VAL0=result.get('BAR_TEMP_VAL0', 0),
            QUENCH_CW_FLOW_ENTRY_VAL0=result.get('QUENCH_CW_FLOW_ENTRY_VAL0', 0),
            GEAR_OIL_L_PR_VAL0=result.get('GEAR_OIL_L_PR_VAL0', 0),
            STANDS_OIL_L_PR_VAL0=result.get('STANDS_OIL_L_PR_VAL0', 0),
            TUNDISH_TEMP_VAL0=result.get('TUNDISH_TEMP_VAL0', 0),
            FURNACE_TEMPERATURE=result.get('FURNACE_TEMPERATURE', 0),
            RM_MOTOR_COOL_WATER_VAL0=result.get('RM_MOTOR_COOL_WATER_VAL0', 0),
            ROLL_MILL_AMPS_VAL0=result.get('ROLL_MILL_AMPS_VAL0', 0),
            RM_COOL_WATER_FLOW_VAL0=result.get('RM_COOL_WATER_FLOW_VAL0', 0),
            EMULSION_LEVEL_ANALO_VAL0=result.get('EMULSION_LEVEL_ANALO_VAL0', 0),
            UTS=UTS,
            Elongation=Elongation,
            Conductivity=Conductivity,
            Percent_SI=result.get('%SI', 0.001),
            Percent_FE=result.get('%FE', 0.001),
            Percent_TI=result.get('%TI', 0.001),
            Percent_V=result.get('%V', 0.001),
            Percent_AL=result.get('%AL', 0.001)
        )
        prediction.save()  # Save the prediction to the database
        try:
            asyncio.run(ws_client(result))
        except Exception as e:
            logger.error("Error sending data to WebSocket server: %s", e)
            return Response({"error": str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)
        return Response(result)  # Return the result in the response
    except Exception as e:
        return Response({"error": str(e)}, status=500)
# @api_view(['POST'])
# def reverse_predict_api(request):
#     # Extract the three input values from the request
#     UTS = request.data.get("UTS")
#     Elongation = request.data.get("Elongation")
#     Conductivity = request.data.get("Conductivity")

#     # Ensure all values are provided
#     if None in (UTS, Elongation, Conductivity):
#         return Response({"error": "All three values (UTS, Elongation, Conductivity) are required."}, status=400)

#     # Create a dictionary of inputs
#     input_data = {
#         "UTS": UTS,
#         "Elongation": Elongation,
#         "Conductivity": Conductivity
#     }

#     # Pass the dictionary to reverse_predict
#     try:
#         result = reverse_predict(input_data)  # Single argument
        
#         if isinstance(result, str):
#             try:
#                 result = json.loads(result)  # Assuming result is a JSON string
#             except json.JSONDecodeError:
#                 return Response({"error": "Invalid JSON format returned from reverse_predict"}, status=400)

#         # Save the result to the database (Prediction model)
#         prediction = Prediction(
#             EMUL_OIL_L_TEMP_PV_VAL0=result.get('EMUL_OIL_L_TEMP_PV_VAL0', 0),
#             STAND_OIL_L_TEMP_PV_REAL_VAL0=result.get('STAND_OIL_L_TEMP_PV_REAL_VAL0', 0),
#             GEAR_OIL_L_TEMP_PV_REAL_VAL0=result.get('GEAR_OIL_L_TEMP_PV_REAL_VAL0', 0),
#             EMUL_OIL_L_PR_VAL0=result.get('EMUL_OIL_L_PR_VAL0', 0),
#             QUENCH_CW_FLOW_EXIT_VAL0=result.get('QUENCH_CW_FLOW_EXIT_VAL0', 0),
#             CAST_WHEEL_RPM_VAL0=result.get('CAST_WHEEL_RPM_VAL0', 0),
#             BAR_TEMP_VAL0=result.get('BAR_TEMP_VAL0', 0),
#             QUENCH_CW_FLOW_ENTRY_VAL0=result.get('QUENCH_CW_FLOW_ENTRY_VAL0', 0),
#             GEAR_OIL_L_PR_VAL0=result.get('GEAR_OIL_L_PR_VAL0', 0),
#             STANDS_OIL_L_PR_VAL0=result.get('STANDS_OIL_L_PR_VAL0', 0),
#             TUNDISH_TEMP_VAL0=result.get('TUNDISH_TEMP_VAL0', 0),
#             FURNACE_TEMPERATURE=result.get('FURNACE_TEMPERATURE', 0),
#             RM_MOTOR_COOL_WATER_VAL0=result.get('RM_MOTOR_COOL_WATER_VAL0', 0),
#             ROLL_MILL_AMPS_VAL0=result.get('ROLL_MILL_AMPS_VAL0', 0),
#             RM_COOL_WATER_FLOW_VAL0=result.get('RM_COOL_WATER_FLOW_VAL0', 0),
#             EMULSION_LEVEL_ANALO_VAL0=result.get('EMULSION_LEVEL_ANALO_VAL0', 0),
#             UTS=UTS,
#             Elongation=Elongation,
#             Conductivity=Conductivity,
#             Percent_SI=result.get('%SI', 0.001),
#             Percent_FE=result.get('%FE', 0.001),
#             Percent_TI=result.get('%TI', 0.001),
#             Percent_V=result.get('%V', 0.001),
#             Percent_AL=result.get('%AL', 0.001)
#         )
#         prediction.save()  # Save the prediction to the database

#         return Response(result)  # Return the result in the response
#     except Exception as e:
#         return Response({"error": str(e)}, status=500)
# @api_view(['GET'])
# def predict_with_inputs_api(request):
#     print("REQUEST.DATA",request.data)
    
#     csv_file_path = "D:/SIH_Project/Project/Prediction/Input_Data.csv"
#     with open(csv_file_path, mode='r') as file:
#         csv_reader = csv.reader(file)
#         next(csv_reader)
#         result=[]
#         for row in csv_reader:
#             result.append(row)
#     # print(result)
    
#     for i in range (0,len(result)):
#         json_data = {
#             "EMUL_OIL_L_TEMP_PV_VAL0" : result[i][1],
#             "STAND_OIL_L_TEMP_PV_REAL_VAL0" : result[i][2],
#             "GEAR_OIL_L_TEMP_PV_REAL_VAL0" : result[i][3],
#             "EMUL_OIL_L_PR_VAL0" : result[i][4],
#             "QUENCH_CW_FLOW_EXIT_VAL0" : result[i][5],
#             "CAST_WHEEL_RPM_VAL0" : result[i][6],
#             "BAR_TEMP_VAL0" : result[i][7],
#             "QUENCH_CW_FLOW_ENTRY_VAL0" : result[i][8],
#             "GEAR_OIL_L_PR_VAL0" : result[i][9],
#             "STANDS_OIL_L_PR_VAL0" : result[i][10],
#             "TUNDISH_TEMP_VAL0" : result[i][11],
#             "RM_MOTOR_COOL_WATER__VAL0" : result[i][12],
#             "ROLL_MILL_AMPS_VAL0" : result[i][13],
#             "RM_COOL_WATER_FLOW_VAL0" : result[i][14],
#             "EMULSION_LEVEL_ANALO_VAL0" : result[i][15], 
#             "Furnace_Temperature" : result[i][16],
#             "%SI" : result[i][17],
#             "%FE" : result[i][18],
#             "%TI" : result[i][19],
#             "%V" : result[i][20],
#             "%AL" : result[i][21]
#             }
#     print(json_data)
#     result1 = predict_with_inputs(json_data)
#     # asyncio.run(ws_client(result1))
#     if isinstance(result1, str):
#         try:
#             result = json.loads(result1)  # Convert JSON string to dictionary
#         except json.JSONDecodeError:
#             return Response({"error": "Invalid JSON format returned from reverse_predict"}, status=400)
#     return Response(result1)

@api_view(['GET'])
def predict_with_inputs_api(request):
    # print("REQUEST.DATA", request.data)

    csv_file_path = "D:/SIH_Project/Project/Prediction/Test_final_Data_With_anomaly.csv"
    with open(csv_file_path, mode='r') as file:
        csv_reader = csv.reader(file)
        next(csv_reader)  # Skip header
        result = []
        for row in csv_reader:
            result.append(row)

    for i in range(len(result)):
        json_data = {
            "EMUL_OIL_L_TEMP_PV_VAL0": result[i][1],
            "STAND_OIL_L_TEMP_PV_REAL_VAL0": result[i][2],
            "GEAR_OIL_L_TEMP_PV_REAL_VAL0": result[i][3],
            "EMUL_OIL_L_PR_VAL0": result[i][4],
            "QUENCH_CW_FLOW_EXIT_VAL0": result[i][5],
            "CAST_WHEEL_RPM_VAL0": result[i][6],
            "BAR_TEMP_VAL0": result[i][7],
            "QUENCH_CW_FLOW_ENTRY_VAL0": result[i][8],
            "GEAR_OIL_L_PR_VAL0": result[i][9],
            "STANDS_OIL_L_PR_VAL0": result[i][10],
            "TUNDISH_TEMP_VAL0": result[i][11],
            "RM_MOTOR_COOL_WATER__VAL0": result[i][12],
            "ROLL_MILL_AMPS_VAL0": result[i][13],
            "RM_COOL_WATER_FLOW_VAL0": result[i][14],
            "EMULSION_LEVEL_ANALO_VAL0": result[i][15],
            "%SI": result[i][16],
            "%FE": result[i][17],
            "%TI": result[i][18],
            "%V": result[i][19],
            "%AL": result[i][20],
            "Furnace_Temperature": result[i][21]
        }
        # print(json_data)
        
        # Call the prediction function
        result1 = predict_with_inputs(json_data)  # Assuming this returns a string

        # If the result is a string, parse it into a dictionary
        if isinstance(result1, str):
            try:
                result1 = json.loads(result1)  # Convert JSON string to dictionary
            except json.JSONDecodeError:
                return Response({"error": "Invalid JSON format returned from reverse_predict"}, status=400)
        gaurav = {
            "EMUL_OIL_L_TEMP_PV_VAL0" : result1.get('EMUL_OIL_L_TEMP_PV_VAL0', 0),
            "STAND_OIL_L_TEMP_PV_REAL_VAL0" : result1.get('STAND_OIL_L_TEMP_PV_REAL_VAL0', 0),
            "GEAR_OIL_L_TEMP_PV_REAL_VAL0": result1.get('GEAR_OIL_L_TEMP_PV_REAL_VAL0', 0),
            "EMUL_OIL_L_PR_VAL0":result1.get('EMUL_OIL_L_PR_VAL0', 0),
            "QUENCH_CW_FLOW_EXIT_VAL0":result1.get('QUENCH_CW_FLOW_EXIT_VAL0', 0),
            "CAST_WHEEL_RPM_VAL0":result1.get('CAST_WHEEL_RPM_VAL0', 0),
            "BAR_TEMP_VAL0":result1.get('BAR_TEMP_VAL0', 0),
            "QUENCH_CW_FLOW_ENTRY_VAL0":result1.get('QUENCH_CW_FLOW_ENTRY_VAL0', 0),
            "GEAR_OIL_L_PR_VAL0":result1.get('GEAR_OIL_L_PR_VAL0', 0),
            "STANDS_OIL_L_PR_VAL0":result1.get('STANDS_OIL_L_PR_VAL0', 0),
            "TUNDISH_TEMP_VAL0":result1.get('TUNDISH_TEMP_VAL0', 0),
            "FURNACE_TEMPERATURE":result1.get('Furnace_Temperature', 0),
            "RM_MOTOR_COOL_WATER_VAL0":result1.get('RM_MOTOR_COOL_WATER__VAL0', 0),
            "ROLL_MILL_AMPS_VAL0":result1.get('ROLL_MILL_AMPS_VAL0', 0),
            "RM_COOL_WATER_FLOW_VAL0":result1.get('RM_COOL_WATER_FLOW_VAL0', 0),
            "EMULSION_LEVEL_ANALO_VAL0":result1.get('EMULSION_LEVEL_ANALO_VAL0', 0),
            "UTS":result1.get('UTS', 0),
            "Elongation":result1.get('Elongation', 0),
            "Conductivity":result1.get('Conductivity', 0),
            "Percent_SI":result1.get('%SI', 0.001),
            "Percent_FE":result1.get('%FE', 0.001),
            "Percent_TI":result1.get('%TI', 0.001),
            "Percent_V":result1.get('%V', 0.001),
            "Percent_AL" : result1.get('%AL', 0.001)
        }
        # Save the result to the database
        prediction = Prediction(
            EMUL_OIL_L_TEMP_PV_VAL0=result1.get('EMUL_OIL_L_TEMP_PV_VAL0', 0),
            STAND_OIL_L_TEMP_PV_REAL_VAL0=result1.get('STAND_OIL_L_TEMP_PV_REAL_VAL0', 0),
            GEAR_OIL_L_TEMP_PV_REAL_VAL0=result1.get('GEAR_OIL_L_TEMP_PV_REAL_VAL0', 0),
            EMUL_OIL_L_PR_VAL0=result1.get('EMUL_OIL_L_PR_VAL0', 0),
            QUENCH_CW_FLOW_EXIT_VAL0=result1.get('QUENCH_CW_FLOW_EXIT_VAL0', 0),
            CAST_WHEEL_RPM_VAL0=result1.get('CAST_WHEEL_RPM_VAL0', 0),
            BAR_TEMP_VAL0=result1.get('BAR_TEMP_VAL0', 0),
            QUENCH_CW_FLOW_ENTRY_VAL0=result1.get('QUENCH_CW_FLOW_ENTRY_VAL0', 0),
            GEAR_OIL_L_PR_VAL0=result1.get('GEAR_OIL_L_PR_VAL0', 0),
            STANDS_OIL_L_PR_VAL0=result1.get('STANDS_OIL_L_PR_VAL0', 0),
            TUNDISH_TEMP_VAL0=result1.get('TUNDISH_TEMP_VAL0', 0),
            FURNACE_TEMPERATURE=result1.get('Furnace_Temperature', 0),
            RM_MOTOR_COOL_WATER_VAL0=result1.get('RM_MOTOR_COOL_WATER__VAL0', 0),
            ROLL_MILL_AMPS_VAL0=result1.get('ROLL_MILL_AMPS_VAL0', 0),
            RM_COOL_WATER_FLOW_VAL0=result1.get('RM_COOL_WATER_FLOW_VAL0', 0),
            EMULSION_LEVEL_ANALO_VAL0=result1.get('EMULSION_LEVEL_ANALO_VAL0', 0),
            UTS=result1.get('UTS', 0),
            Elongation=result1.get('Elongation', 0),
            Conductivity=result1.get('Conductivity', 0),
            Percent_SI=result1.get('%SI', 0.001),
            Percent_FE=result1.get('%FE', 0.001),
            Percent_TI=result1.get('%TI', 0.001),
            Percent_V=result1.get('%V', 0.001),
            Percent_AL=result1.get('%AL', 0.001)
        )
        prediction.save() # Save the prediction to the database
        
        mongo_uri = "mongodb+srv://TEST:12345@mubustest.yfyj3.mongodb.net/investz?retryWrites=true&w=majority"
        client = MongoClient(mongo_uri)
        db = client["NALCO"]
        nalco = db["NALCO"]
        entry_data = gaurav
        nalco.insert_one(entry_data)
        try:
            asyncio.run(ws_client(result1))
        except Exception as e:
            logger.error("Error sending data to WebSocket server: %s", e)
            return Response({"error": str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)
    return Response(result1)

@api_view(['POST'])
def manual_prediction(request):
    # Get the result from predict_with_inputs function
    result = predict_with_inputs(request.data)
    print(request.data)
    
    # If result is a string (containing JSON-like data)
    if isinstance(result, str):
        try:
            result = json.loads(result)  # Convert string to dictionary
        except json.JSONDecodeError:
            return Response({"error": "Invalid JSON format returned from prediction"}, status=status.HTTP_400_BAD_REQUEST)
    
    # Return the result as a JSON response
    return Response(result, status=status.HTTP_200_OK)


@csrf_exempt
def predictProp(request):
    if request.method == 'GET':
        showProp = Prediction.objects.all()
        serializer = PredictionSerializer(showProp, many=True)
        # data = list(showProp.values())

        return JsonResponse(serializer.data, safe=False)

    elif request.method == 'POST':
        jsonData = JSONParser().parse(request)

        ans=predict_with_inputs(jsonData)
        serializer = PredictionSerializer(data=ans)

        if serializer.is_valid():
            serializer.save()
        
            # Broadcasting data to WebSocket clients
            # message = json.dumps({"message": jsonData})  # Convert jsonData to JSON string
            # for client in websocket_clients:
            #     try:
            #         # asyncio.run(client.send(message))
                
            #     except:
            #         pass
            
            return JsonResponse(jsonData, safe=False)
        else:
            return JsonResponse(serializer.errors, safe=False)



@api_view(['POST', 'GET'])
def employee_login(request):
    if request.method == 'POST':
        try:
            # Parse JSON data for login
            data = json.loads(request.body)
            print(data)
            employee_id = data.get('employee_id')
            password = data.get('password')

            # Validate input fields
            if not employee_id or not password:
                return Response({
                    'status': 'error', 
                    'message': 'Employee ID and password are required'
                }, status=status.HTTP_400_BAD_REQUEST)

            try:
                # Check credentials
                employee = Employee.objects.get(employee_id=employee_id, password=password)
                return Response({
                    'status': 'success', 
                    'message': 'Login successful', 
                    'employee_id': employee.employee_id
                }, status=status.HTTP_200_OK)

            except Employee.DoesNotExist:
                return Response({
                    'status': 'error', 
                    'message': 'Invalid credentials'
                }, status=status.HTTP_401_UNAUTHORIZED)

        except json.JSONDecodeError:
            return Response({
                'status': 'error', 
                'message': 'Invalid JSON format'
            }, status=status.HTTP_400_BAD_REQUEST)

    elif request.method == 'GET':
        # Get employee ID from query parameters
        employee_id = request.GET.get('employee_id')

        if not employee_id:
            # If no employee ID is provided, return all employees
            try:
                employees = Employee.objects.all()
                employee_data = [{
                    'employee_id': emp.employee_id
                } for emp in employees]
                
                return Response({
                    'status': 'success',
                    'employees': employee_data
                }, status=status.HTTP_200_OK)
            
            except Exception as e:
                return Response({
                    'status': 'error', 
                    'message': 'Error retrieving employees'
                }, status=status.HTTP_500_INTERNAL_SERVER_ERROR)
        
        try:
            # Retrieve specific employee by ID
            employee = Employee.objects.get(employee_id=employee_id)
            return Response({
                'status': 'success',
                'employee_id': employee.employee_id
            }, status=status.HTTP_200_OK)

        except Employee.DoesNotExist:
            return Response({
                'status': 'error', 
                'message': 'Employee not found'
            }, status=status.HTTP_404_NOT_FOUND)



@csrf_exempt
def suggestion_api(request):
    if request.method == 'POST':
        try:
            # Parse the JSON body
            body = json.loads(request.body)
            input_data = body.get('input', {})

            # Extract inputs from the JSON
            parameter_to_change = input_data.get('variable')
            current_value = input_data.get('old_value')
            new_value = input_data.get('new_value')
            input_values = input_data.get('values', {})

            if parameter_to_change not in ['UTS', 'Elongation', 'Conductivity']:
                return JsonResponse({"error": "Invalid parameter to change."}, status=status.HTTP_400_BAD_REQUEST)

            # Define the model paths
            model_paths = {
                'Conductivity': 'D:/SIH_Project/Project/Prediction/xgboost_model_output_Conductivity.pkl',
                'Elongation': 'D:/SIH_Project/Project/Prediction/xgboost_model_output_Elongation.pkl',
                'UTS': 'D:/SIH_Project/Project/Prediction/xgboost_model_output_UTS.pkl'
            }

            # Initialize min_max_values as a dictionary
            min_max_values = {}

            # Load data and calculate min-max values for normalization
            df = pd.read_csv('D:/SIH_Project/Project/Prediction/suggestion_predicted_df.csv')
            relevant_columns = [
                'EMUL_OIL_L_TEMP_PV_VAL0', 'STAND_OIL_L_TEMP_PV_REAL_VAL0',
                'GEAR_OIL_L_TEMP_PV_REAL_VAL0', 'EMUL_OIL_L_PR_VAL0',
                'QUENCH_CW_FLOW_EXIT_VAL0', 'CAST_WHEEL_RPM_VAL0', 'BAR_TEMP_VAL0',
                'QUENCH_CW_FLOW_ENTRY_VAL0', 'GEAR_OIL_L_PR_VAL0',
                'STANDS_OIL_L_PR_VAL0', 'TUNDISH_TEMP_VAL0',
                'RM_MOTOR_COOL_WATER__VAL0', 'ROLL_MILL_AMPS_VAL0',
                'RM_COOL_WATER_FLOW_VAL0', 'EMULSION_LEVEL_ANALO_VAL0', 'Furnace_Temperature'
            ]
            
            for col in relevant_columns:
                min_v = df[col].min()
                max_v = df[col].max()
                min_max_values[col] = [min_v, max_v]  # Store as a dictionary

            # Call optimize_parameters with all required arguments
            processed_data = optimize_parameters(
                parameter_to_change,
                current_value,
                new_value,
                input_values,
                model_paths,
                min_max_values
            )

            # Ensure processed_data is valid JSON
            if isinstance(processed_data, str):
                try:
                    processed_data = json.loads(processed_data)
                except json.JSONDecodeError:
                    return JsonResponse({"error": "Invalid JSON format returned from optimize_parameters"}, status=400)

            # Return the processed data as JSON
            return JsonResponse(processed_data, status=200)

        except Exception as e:
            return JsonResponse({"error": str(e)}, status=500)

    return JsonResponse({"error": "Method not allowed."}, status=405)
