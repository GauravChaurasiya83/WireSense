import asyncio
import websockets

# Creating WebSocket server
async def ws_server(websocket):
    print("WebSocket: Client connected.")
    try:
        message = "Welcome to the WebSocket server!"
        await websocket.send(message)
        print(f"Message sent to client: {message}")
    except websockets.ConnectionClosed:
        print("WebSocket: Connection closed.")

# Start the WebSocket server
async def main():
    async with websockets.serve(ws_server, "0.0.0.0", 7897):
        print("WebSocket server started on ws://0.0.0.0:7897")
        await asyncio.Future()  # Run server forever

if __name__ == "__main__":
    asyncio.run(main())
