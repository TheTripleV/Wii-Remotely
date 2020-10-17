import pyvjoy

class WiiMote():
    def __init__(self, controller_id: int=1):
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

    def setButton(self, button: str, value: bool):
        try:
            button = self.button_mapping[button]
        except KeyError:
            print("Failed to find button mapping. Check your spelling?")
            return

        if value is True:
            self.buttons_pressed.append(button)
        else:
            try:
                self.buttons_pressed.remove(button)
            except:
                pass
        
        res = 0
        for button in self.buttons_pressed:
            res |= (2**(button-1))

        self.j.data.lButtons = res
        self.j.update()
        return True

    def clearButtons(self):
        self.buttons_pressed = []
        self.j.data.lButtons = 0
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