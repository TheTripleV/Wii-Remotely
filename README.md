# phonejoy

Play Nintendo Wii games with friends remotely (and safely)!

Use your phone as a Wii Controller and it will be streamed to the host.


### Server

#### Dependencies
- Python >= 3.7
- vJoy
- Dolphin Emulator

#### Usage
1. Install python packages: `pip install -r ./server/requirements.txt`
2. Setup vJoy with 2 joysticks each with 11 buttons
3. Run server: `python app.py`
4. Map Joystick values in Dolphin Emulator
5. Connect with phone and enjoy!

### Phone

#### Dependencies
- Xcode 12
- Swift 5
- iOS 14

#### Usage
1. Build and Deploy xcode project to iOS device
2. Open app and connect to server!