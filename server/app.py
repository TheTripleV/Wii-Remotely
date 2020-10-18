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

wiimotes = {1: WiiMote(1), 2: WiiMote(2)}

@socketio.on("connect")
def connect():
    print("Phone connected.")


@socketio.on("disconnect")
def disconnect():
    print("Phone disconnected.")


@socketio.on("buttons")
def handle_buttons(json):
    wiimote = wiimotes[json["id"]]
    print(json["id"])
    del json["id"]
    for button, value in json.items():
        wiimote.setButton(button, value)


@socketio.on("gyro")
def handle_gyro(json):
    wiimote = wiimotes[json["id"]]
    del json["id"]

    maximum_gyro = 20.0
    x, y, z = json.values()
    x, y, z = rescale(x, y, z, maximum_gyro)


    wiimote.setAxis(pyvjoy.HID_USAGE_RX, x)
    wiimote.setAxis(pyvjoy.HID_USAGE_RY, y)
    wiimote.setAxis(pyvjoy.HID_USAGE_RZ, z)


@socketio.on("tilt")
def handle_tilt(json):
    wiimote = wiimotes[json["id"]]
    del json["id"]

    maximum_tilt = 85.0
    x, y, z = json.values()
    x, y, z = rescale(x, y, z, maximum_tilt)

    wiimote.setAxis(pyvjoy.HID_USAGE_SL0, x)
    wiimote.setAxis(pyvjoy.HID_USAGE_SL1, z)


@socketio.on("accel")
def handle_acceleration(json):
    wiimote = wiimotes[json["id"]]
    del json["id"]

    maximum_accel = 4.0
    x, y, z = json.values()
    x, y, z = rescale(x, y, z, maximum_accel)

    wiimote.setAxis(pyvjoy.HID_USAGE_X, x)
    wiimote.setAxis(pyvjoy.HID_USAGE_Y, y)
    wiimote.setAxis(pyvjoy.HID_USAGE_Z, z)


def rescale(x, y, z, max_real_value, max_controller_value=16384):
    x *= (max_controller_value / max_real_value)
    x += max_controller_value

    y *= (max_controller_value / max_real_value)
    y += max_controller_value

    z *= (max_controller_value / max_real_value)
    z += max_controller_value

    return int(x), int(y), int(z)


if __name__ == "__main__":
    socketio.run(app, host="0.0.0.0")
