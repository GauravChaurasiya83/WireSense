import json
from channels.generic.websocket import AsyncWebsocketConsumer

class PredictionConsumer(AsyncWebsocketConsumer):
    async def connect(self):
        # Add the client to the group
        await self.channel_layer.group_add("predictions_group", self.channel_name)
        await self.accept()
        print("CONNECTED")

    async def disconnect(self, close_code):
        # Remove the client from the group
        await self.channel_layer.group_discard("predictions_group", self.channel_name)
        print("DISCONNECTED")

    async def prediction_message(self, event):
        # Send the message to the WebSocket client
        message = event["message"]
        await self.send(text_data=json.dumps(message))
