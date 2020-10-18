import time
from typing import Callable
from flask import Flask
from flask.wrappers import Request
from flask_socketio import SocketIO
from rich import print


app = Flask(__name__)
socketio = SocketIO(app)

@socketio.on("connect")
def connect():
    print("Phone connected:")

@socketio.on("disconnect")
def disconnect():
    print("Client disconnected")

@socketio.on("json")
def handle_json(json):
    print(json)
    # player_num = json["player_num"]


if __name__ == "__main__":
    socketio.run(app, host="0.0.0.0")
