import pyvjoy

HID_USAGE_X = 0x30
HID_USAGE_Y	= 0x31
HID_USAGE_Z	= 0x32
HID_USAGE_RX = 0x33
HID_USAGE_RY = 0x34
HID_USAGE_RZ = 0x35
HID_USAGE_SL0 = 0x36
HID_USAGE_SL1 = 0x37
HID_USAGE_WHL = 0x38
HID_USAGE_POV = 0x39

class WiiMote():
    def __init__(self, controller_id: int=1):
        self.j = pyvjoy.VJoyDevice(controller_id)
        self.controller_id = controller_id
        self.button_mapping = {
            "A":1,
            "B":2,
            "1":3,
            "2":4,
            "-":5,
            "+":6,
            "HOME":7,
            "DPAD_UP":8,
            "DPAD_DOWN":9,
            "DPAD_LEFT":10,
            "DPAD_RIGHT":11
        }

        # self.axis_mapping = {
        #     HID_USAGE_X,
        #     HID_USAGE_Y,
        #     HID_USAGE_Z,
        #     HID_USAGE_RX,
        #     HID_USAGE_RY,
        #     HID_USAGE_RZ,
        #     HID_USAGE_SL0,
        #     HID_USAGE_SL1,
        #     HID_USAGE_WH,
        #     HID_USAGE_POV
        # }

    def setButton(self, button: str, value: bool):
        try:
            button = self.button_mapping[button]
        except KeyError:
            print("Failed to find button mapping. Check your spelling?")
            return

        self.j._sdk.SetBtn(int(value), self.controller_id, button)

    def clearButtons(self):
        self.buttons_pressed = []
        self.j._sdk.ResetButtons()

    def setAxis(self, axis_id: int, axis_value: int):
        self.j._sdk.SetAxis(axis_value, self.controller_id, axis_id)

def main():
    wii = WiiMote()
    wii.setButton("A", True)
    wii.setButton("B", True)
    wii.setButton("-", True)
    wii.setButton("-", False)
    wii.setButton("B", False)
    wii.setButton("A", False)
    wii.setAxis(pyvjoy.HID_USAGE_X, 0x4000)
    wii.setAxis(pyvjoy.HID_USAGE_Y, 0x8000)


if __name__ == "__main__":
    main()