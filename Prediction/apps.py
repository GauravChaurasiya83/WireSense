from django.apps import AppConfig


class PredictionConfig(AppConfig):
    default_auto_field = 'django.db.models.BigAutoField'
    name = 'Prediction'

from django.apps import AppConfig
import websockets
import asyncio
import json
import threading 
import requests


clients = set()

async def ws_server(websocket):
    print("WebSocket: Server Started.")
    
    clients.add(websocket)
    try:
        while True:
            data = await websocket.recv()
            
            # Parse the JSON data
            try:
                data_dict = json.loads(data)
            except json.JSONDecodeError:
                await websocket.send("Invalid data format. Please send a valid JSON object.")
                continue



            def api_call(data_dict):
                try:
                    print("TYPE",data_dict['type'])
                    pro_dict=data_dict['input']
                    if data_dict['type']=='1':
                        response = requests.post("http://127.0.0.1:8000/api/reverse_predict/", json=pro_dict)

                        # Check the response
                        if response.status_code == 200:
                            print("API call successful!")
                            print("Response:", response.json())
                        else:
                            print(f"API call failed with status code: {response.status_code}")
                            print("Response:", response.text)
                    if data_dict['type']=='0':
                        response = requests.get("http://127.0.0.1:8000/api/predict_with_inputs/")
                        if response.status_code == 200:
                            print("API call successful!")
                            print("Response:", response.json())
                        else:
                            print(f"API call failed with status code: {response.status_code}")
                            print("Response:", response.text)
                        
                except Exception as e:
                    print(f"An error occurred during the API call: {e}")
           
            api_thread = threading.Thread(target=api_call,args=(data_dict,))
            api_thread.start()




            # Broadcast data to all connected clients except the sender
            for client in clients:
                if client != websocket:
                    try:
                        await client.send(json.dumps(data_dict))
                    except Exception as e:
                        print(e)
    except websockets.ConnectionClosedOK:
        print("Connection closed gracefully by client.")
    except websockets.ConnectionClosedError:
        print("Connection with the client closed unexpectedly.")
    except Exception as e:
        print(f"An unexpected error occurred: {e}")
    finally:
        # Remove client from the set of connected clients
        clients.remove(websocket)

async def start_ws_server():
    # Start the WebSocket server
    server = await websockets.serve(ws_server, "0.0.0.0", 7890)
    await server.wait_closed()

def run_ws_server():
    # Running asyncio event loop for WebSocket server in a separate thread
    asyncio.run(start_ws_server())


class PredictionConfig(AppConfig):
    default_auto_field = 'django.db.models.BigAutoField'
    name='Prediction'
    _has_run = False

    def ready(self):
        if not self._has_run:
            print("Server has started and MyApp is ready.")
            # Start WebSocket server in a separate thread
            ws_thread = threading.Thread(target=run_ws_server)
            ws_thread.daemon = True  # Ensures the thread exits when the main program exits
            ws_thread.start()
            self._has_run = True