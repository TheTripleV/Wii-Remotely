import time
from typing import Callable
from flask import Flask
from flask.wrappers import Request
from flask_socketio import SocketIO
from rich import print

from wiimote import WiiMote
import pyvjoy

app = Flask(__name__)
socketio = SocketIO(app)

w = WiiMote(1)

@socketio.on("connect")
def connect():
    print("Phone connected:")

@socketio.on("disconnect")
def disconnect():
    print("Client disconnected")

@socketio.on("buttons")
def handle_buttons(json):
    for button, value in json.items():
        print("Setting", button, "to", value)
        w.setButton(button, value)
    print(json)
    

@socketio.on("gyro")
def handle_gyro(json):
    maximum_gyro = 20.0
    x, y, z = json.values()

    x *= (16384 / maximum_gyro)
    x += 16384

    y *= (16384 / maximum_gyro)
    y += 16384

    z *= (16384 / maximum_gyro)
    z += 16384

    x, y, z = int(x), int(y), int(z)

    # set X
    w.setAxis(pyvjoy.HID_USAGE_RX, x)
    # set Y
    w.setAxis(pyvjoy.HID_USAGE_RY, y)
    # set Z
    w.setAxis(pyvjoy.HID_USAGE_RZ, z)


@socketio.on("tilt")
def handle_tilt(json):
    maximum_tilt = 85.0
    x, y, z = json.values()
    print(int(x), int(y), int(z))

    x *= (16384 / maximum_tilt)
    x += 16384

    y *= (16384 / maximum_tilt)
    y += 16384

    z *= (16384 / maximum_tilt)
    z += 16384

    x, y, z = int(x), int(y), int(z)

    # set X
    w.setAxis(pyvjoy.HID_USAGE_SL0, x)
    # set Y
    # w.setAxis(pyvjoy.HID_USAGE_SL1, y)
    # set Z
    w.setAxis(pyvjoy.HID_USAGE_SL1, z)


@socketio.on("accel")
def handle_acceleration(json):
    maximum_accel = 4.0
    x, y, z = json.values()

    x *= (16384 / maximum_accel)
    x += 16384

    y *= (16384 / maximum_accel)
    y += 16384

    z *= (16384 / maximum_accel)
    z += 16384

    x, y, z = int(x), int(y), int(z)

    # set X
    w.setAxis(pyvjoy.HID_USAGE_X, x)
    # set Y
    w.setAxis(pyvjoy.HID_USAGE_Y, y)
    # set Z
    w.setAxis(pyvjoy.HID_USAGE_Z, z)



if __name__ == "__main__":
    socketio.run(app, host="0.0.0.0")
