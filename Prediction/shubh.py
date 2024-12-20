# import numpy as np
# import xgboost as xgb
# from sklearn.preprocessing import StandardScaler
# import pickle
# import json

# # Load the three saved models
# with open("D:/SIH_Project/Project/Prediction/xgboost_model_output_Conductivity.pkl", "rb") as f:
#     model_conductivity = pickle.load(f)

# with open("D:/SIH_Project/Project/Prediction/xgboost_model_output_Elongation.pkl", "rb") as f:
#     model_elongation = pickle.load(f)

# with open("D:/SIH_Project/Project/Prediction/xgboost_model_output_UTS.pkl", "rb") as f:
#     model_uts = pickle.load(f)

# # Re-initialize the feature scaler (use the same scaler that was used during training)
# scaler_X = StandardScaler()

# def predict_with_inputs(input_json):
#     """
#     Predicts the output (UTS, Elongation, Conductivity) using three separate models
#     and returns the input features along with the predictions in JSON format.

#     Parameters:
#     input_json (dict): A dictionary containing 21 input feature values.

#     Returns:
#     str: A JSON string containing the original input values and predicted values.
#     """
#     # Parse the JSON input
#     input_data_dict = input_json
#     # Ensure the input contains 21 features
#     if len(input_data_dict) != 21:
#         return json.dumps({"error": "Input must contain exactly 21 feature values."})

#     # Convert the input feature values to a list
#     input_values = list(input_data_dict.values())

#     # Convert the input values into a numpy array and reshape for scaling
#     input_data = np.array(input_values).reshape(1, -1)

#     # Scale the input features using the same scaler as during training
#     input_data_scaled = scaler_X.fit_transform(input_data)

#     # Make predictions using the three trained models
#     conductivity = model_conductivity.predict(input_data_scaled)[0]
#     elongation = model_elongation.predict(input_data_scaled)[0]
#     uts = model_uts.predict(input_data_scaled)[0]

#     # Add the predictions to the input JSON data
#     input_data_dict["Conductivity"] = float(conductivity)
#     input_data_dict["Elongation"] = float(elongation)
#     input_data_dict["UTS"] = float(uts)

#     # Return the combined input and predictions as JSON
#     return json.dumps(input_data_dict, indent=2)

# # Example usage of the function with 21 features
# input_example_json = {
#     "EMUL_OIL_L_TEMP_PV_VAL0": 11,
#     "STAND_OIL_L_TEMP_PV_REAL_VAL0": 8,
#     "GEAR_OIL_L_TEMP_PV_REAL_VAL0": 60,
#     "EMUL_OIL_L_PR_VAL0": 1.5,
#     "QUENCH_CW_FLOW_EXIT_VAL0": 12,
#     "CAST_WHEEL_RPM_VAL0": 100,
#     "BAR_TEMP_VAL0": 75,
#     "QUENCH_CW_FLOW_ENTRY_VAL0": 18,
#     "GEAR_OIL_L_PR_VAL0": 25,
#     "STANDS_OIL_L_PR_VAL0": 30,
#     "TUNDISH_TEMP_VAL0": 22,
#     "RM_MOTOR_COOL_WATER__VAL0": 45,
#     "ROLL_MILL_AMPS_VAL0": 32,
#     "RM_COOL_WATER_FLOW_VAL0": 15,
#     "EMULSION_LEVEL_ANALO_VAL0": 42,
#     "Furnace_Temperature": 35,
#     "%SI": 3.4,
#     "%FE": 4.6,
#     "%TI": 5.8,
#     "%V": 6.9,
#     "%AL": 7.2
# }

# # Get predictions
# predictions_json = predict_with_inputs(input_example_json)
# print(predictions_json)




import numpy as np
import xgboost as xgb
from sklearn.preprocessing import StandardScaler
import pickle
import json
import pandas as pd

# Load the saved models
df = pd.read_csv('D:/SIH_Project/Project/Prediction/Final_Anomaly_Removed_Data.csv')
model_UTS = pickle.load(open("D:/SIH_Project/Project/Prediction/xgboost_model_output_UTS.pkl", "rb"))
model_Elongation = pickle.load(open("D:/SIH_Project/Project/Prediction/xgboost_model_output_Elongation.pkl", "rb"))
model_Conductivity = pickle.load(open("D:/SIH_Project/Project/Prediction/xgboost_model_output_Conductivity.pkl", "rb"))
input_cols = ['EMUL_OIL_L_TEMP_PV_VAL0','STAND_OIL_L_TEMP_PV_REAL_VAL0','GEAR_OIL_L_TEMP_PV_REAL_VAL0','EMUL_OIL_L_PR_VAL0','QUENCH_CW_FLOW_EXIT_VAL0','CAST_WHEEL_RPM_VAL0','BAR_TEMP_VAL0','QUENCH_CW_FLOW_ENTRY_VAL0','GEAR_OIL_L_PR_VAL0','STANDS_OIL_L_PR_VAL0','TUNDISH_TEMP_VAL0','RM_MOTOR_COOL_WATER__VAL0','ROLL_MILL_AMPS_VAL0','RM_COOL_WATER_FLOW_VAL0','EMULSION_LEVEL_ANALO_VAL0','Furnace_Temperature','%SI','%FE', '%TI','%V','%AL']

# Re-initialize the feature scaler (use the same scaler that was used during training)
# Normalization function in range [0, 1]
def normalize_column(column,min_val,max_val):
    return (column - min_val) / (max_val - min_val)

# Inverse normalization function
def inverse_normalize_column(norm_column, min_val, max_val):
    return norm_column * (max_val - min_val) + min_val


def predict_with_inputs(input_json):
    """
    Predicts the output (UTS, Elongation, Conductivity) and returns the input features
    along with the predictions in JSON format.

    Parameters:
    input_json (dict): A dictionary containing 16 input feature values.

    Returns:
    str: A JSON string containing the original input values and predicted values.
    """
    # Parse the JSON input
    if isinstance(input_json, str):  # Check if input is a JSON string
        input_data_dict = json.loads(input_json)
    elif isinstance(input_json, dict):  # If input is already a dict
        input_data_dict = input_json
    else:
        return json.dumps({"error": "Invalid input format. Expected JSON string or dictionary."})

    print(input_data_dict)
    # Ensure the input contains the correct number of features (16)
    if len(input_data_dict) != 21:
        return json.dumps({"error": "Input must contain exactly 21 feature values."})
    
    # Extract numerical fields from the input and convert to a Series
    input_numerical = {key: float(value) for key, value in input_data_dict.items() if key in input_cols}

    # Create a dictionary to store normalized input values
    normalized_values = {}

    for key, value in input_numerical.items():
        # Adjust column name if necessary
        col = key
        # Handle specific column name formatting if required

        # Get the min and max values for the column
        min_val = df[col].min()
        max_val = df[col].max()

        # Normalize the value
        norm_val = normalize_column(value, min_val, max_val)

        # Store normalized value
        normalized_values[col] = norm_val

    # Convert the input feature values to a list
    input_values = list(normalized_values.values())

    # Convert the input values into a numpy array and reshape for scaling
    input_data = np.array(input_values).reshape(1, -1)

    # Make predictions using the three models
    UTS = model_UTS.predict(input_data)
    Elongation = model_Elongation.predict(input_data)
    Conductivity = model_Conductivity.predict(input_data)

    # Denormalize predictions
    UTS_min, UTS_max = df["   UTS"].min(), df["   UTS"].max()
    Elongation_min, Elongation_max = df["Elongation"].min(), df["Elongation"].max()
    Conductivity_min, Conductivity_max = df["Conductivity"].min(), df["Conductivity"].max()

    UTS_value = inverse_normalize_column(float(UTS[0]), UTS_min, UTS_max)
    Elongation_value = inverse_normalize_column(float(Elongation[0]), Elongation_min, Elongation_max)
    Conductivity_value = inverse_normalize_column(float(Conductivity[0]), Conductivity_min, Conductivity_max)

    # Add the predictions to the input JSON data
    input_data_dict["UTS"] = UTS_value
    input_data_dict["Elongation"] = Elongation_value
    input_data_dict["Conductivity"] = Conductivity_value

    # Return the combined input and predictions as JSON
    return json.dumps(input_data_dict, indent=2)

# Example usage of the function with 16 features
#132,59.35745239,45.00061035,54.86810303,2.267818451,3.212454229,1.855242968,564.0334473,152.595629,2.093538284,1.934295654,722.203125,1.297880173,459.3994141,205.4561157,1143.963867,0.12,0.18,0.002,0.004,99.668,758.1726074
input_example_json = {
    "EMUL_OIL_L_TEMP_PV_VAL0": 59.35745239,
    "STAND_OIL_L_TEMP_PV_REAL_VAL0": 45.00061035,
    "GEAR_OIL_L_TEMP_PV_REAL_VAL0":54.86810303,
    "EMUL_OIL_L_PR_VAL0": 2.267818451,
    "QUENCH_CW_FLOW_EXIT_VAL0": 3.212454229,
    "CAST_WHEEL_RPM_VAL0": 1.855242968,
    "BAR_TEMP_VAL0": 564.0334473,
    "QUENCH_CW_FLOW_ENTRY_VAL0": 152.595629,
    "GEAR_OIL_L_PR_VAL0": 2.093538284,
    "STANDS_OIL_L_PR_VAL0": 1.934295654,
    "TUNDISH_TEMP_VAL0": 722.203125,
    "RM_MOTOR_COOL_WATER__VAL0": 1.297880173,
    "ROLL_MILL_AMPS_VAL0": 459.3994141,
    "RM_COOL_WATER_FLOW_VAL0": 205.4561157,
    "EMULSION_LEVEL_ANALO_VAL0": 1143.963867,
    "Furnace_Temperature": 758.1726074,
    "%SI": 0.12,
    "%FE": 0.18,
    "%TI": 0.002,
    "%V": 0.004,
    "%AL": 99.668
}

# Get predictions
predictions_json = predict_with_inputs(input_example_json)

# Output the predictions in JSON format
print(predictions_json)  # This will print the result as JSON

0
