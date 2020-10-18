//
//  Sender.swift
//  wiirii
//
//  Created by Vasista Vovveti on 10/17/20.
//

import Foundation
import SocketIO
import CoreMotion

class Sender : ObservableObject {
    static let shared = Sender()
    let motionManager: CMMotionManager
    
    var timer: Timer?
    
    let socketManager: SocketManager
    let socket: SocketIO.SocketIOClient
    
    var player_id: Int = 1
    
    private var gyro_cache_x: [Double] = []
    private var gyro_cache_y: [Double] = []
    private var gyro_cache_z: [Double] = []
    
    private var accel_cache_x: [Double] = []
    private var accel_cache_y: [Double] = []
    private var accel_cache_z: [Double] = []
    
    private var tilt_cache_x: [Double] = []
    private var tilt_cache_y: [Double] = []
    private var tilt_cache_z: [Double] = []
    
    
    private init(){
        socketManager = SocketManager(socketURL: URL(string: "http://192.168.1.9:8081")!, config: [.log(true), .compress])
//        socketManager = SocketManager(socketURL: URL(string: "https://wiirii2.uc.r.appspot.com")!, config: [.log(true), .compress])
        motionManager = CMMotionManager()
        
        socket = socketManager.defaultSocket
        
        socket.on(clientEvent: .connect) {data, ack in
            print("socket connected")
        }
        
        socket.on(clientEvent: .disconnect) {data, ack in
            print("socket connected")
        }
        
        socket.connect()
    
        motionManager.deviceMotionUpdateInterval = 1 / 20;
        motionManager.startDeviceMotionUpdates();
        
        motionManager.gyroUpdateInterval = 1 / 20
        guard let gyroQueue = OperationQueue.current else { return }
        motionManager.startGyroUpdates(to: gyroQueue) { data, error in
            if let rotation = data?.rotationRate {
                let cache_size = 2
                
                self.gyro_cache_x.insert(rotation.x, at: 0)
                if self.gyro_cache_x.count > cache_size{ self.gyro_cache_x.removeLast() }
                self.gyro_cache_y.insert(rotation.y, at: 0)
                if self.gyro_cache_y.count > cache_size{ self.gyro_cache_y.removeLast() }
                self.gyro_cache_z.insert(rotation.z, at: 0)
                if self.gyro_cache_z.count > cache_size{ self.gyro_cache_z.removeLast() }
                
                let x: Double = self.gyro_cache_x.reduce(0.0, +) / Double(cache_size)
                let y: Double = self.gyro_cache_y.reduce(0.0, +) / Double(cache_size)
                let z: Double = self.gyro_cache_z.reduce(0.0, +) / Double(cache_size)
                
                self.socket.emit("gyro", [
                    "id": self.player_id,
                    "x": x,
                    "y": y,
                    "z": z
                ])
            }
        }

        motionManager.accelerometerUpdateInterval = 1 / 20
        guard let accelQueue = OperationQueue.current else {return}
        motionManager.startAccelerometerUpdates(to: accelQueue) {data, error in
            if let accel = data?.acceleration {
                let cache_size = 2
                
                self.accel_cache_x.insert(accel.x, at: 0)
                if self.accel_cache_x.count > cache_size{ self.accel_cache_x.removeLast() }
                self.accel_cache_y.insert(accel.y, at: 0)
                if self.accel_cache_y.count > cache_size{ self.accel_cache_y.removeLast() }
                self.accel_cache_z.insert(accel.z, at: 0)
                if self.accel_cache_z.count > cache_size{ self.accel_cache_z.removeLast() }
                
                self.socket.emit("accel", [
                    "id": self.player_id,
                    "x": self.accel_cache_x.reduce(0.0, +) / Double(cache_size),
                    "y": self.accel_cache_y.reduce(0.0, +) / Double(cache_size),
                    "z": self.accel_cache_z.reduce(0.0, +) / Double(cache_size)
                ])
            }
        }
        
        guard let motionQueue = OperationQueue.current else {return}
        motionManager.startDeviceMotionUpdates(to: motionQueue) {data, error in
            if let attitude = data?.attitude {
                let cache_size = 2
                
                self.tilt_cache_x.insert(attitude.pitch * 180.0 / 3.14159, at: 0)
                if self.tilt_cache_x.count > cache_size{ self.tilt_cache_x.removeLast() }
                self.tilt_cache_y.insert(attitude.roll * 180.0 / 3.14159, at: 0)
                if self.tilt_cache_y.count > cache_size{ self.tilt_cache_y.removeLast() }
                self.tilt_cache_z.insert(attitude.yaw * 180.0 / 3.14159, at: 0)
                if self.tilt_cache_z.count > cache_size{ self.tilt_cache_z.removeLast() }
//                print(attitude)
                
                self.socket.emit("tilt", [
                    "id": self.player_id,
                    "x": self.tilt_cache_x.sorted(by: <)[self.tilt_cache_x.count / 2],
                    "y": self.tilt_cache_y.sorted(by: <)[self.tilt_cache_y.count / 2],
                    "z": self.tilt_cache_z.sorted(by: <)[self.tilt_cache_z.count / 2]
                ])
            }
        }
        
        timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(sync), userInfo: nil, repeats: true)
    }
    
    deinit {
        timer?.invalidate()
    }
    
    @objc func sync(){
//        socket.emit(
//            "json",
//            [
//                "DPAD_UP": dpadUP,
//                "DPAD_DOWN": dpadDOWN,
//                "DPAD_LEFT": dpadLEFT,
//                "DPAD_RIGHT": dpadRIGHT,
//                "A": A,
//                "B": B,
//                "1": one,
//                "2": two,
//                "-": minus,
//                "HOME": home,
//                "+": plus
//            ]
//        )
    }
    
    
}
