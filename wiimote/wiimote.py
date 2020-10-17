import pyvjoy

class WiiMote():
    def __init__(self, controller_id=1):
        self.j = pyvjoy.VJoyDevice(controller_id)
        self.controller_id = controller_id
        self.buttons_pressed = []
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

    def setButton(self, button, value):
        try:
            button = self.button_mapping[button]
        except KeyError:
            print("Failed to find button mapping. Check your spelling?")

        if value is True:
            self.buttons_pressed.append(button)
        else:
            self.buttons_pressed.remove(button)
        
        res = 0
        for button in self.buttons_pressed:
            res |= (2**(button-1))

        print(res)
        self.j.data.lButtons = res
        self.j.update()

def main():
    wii = WiiMote()
    wii.setButton("A", True)
    wii.setButton("B", True)
    wii.setButton("-", True)
    wii.setButton("-", False)
    wii.setButton("B", False)
    wii.setButton("A", False)

if __name__ == "__main__":
    main()