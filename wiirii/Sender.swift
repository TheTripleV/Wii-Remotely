//
//  Sender.swift
//  wiirii
//
//  Created by Vasista Vovveti on 10/17/20.
//

import Foundation
import SocketIO

class Sender {
    static let shared = Sender()
    
    var timer: Timer?
    
    let manager: SocketManager
    let socket: SocketIO.SocketIOClient
    
    var dpadUP: Bool = false
    var dpadDOWN: Bool = false
    var dpadLEFT: Bool = false
    var dpadRIGHT: Bool = false
    var A: Bool = false
    var B: Bool = false
    var plus: Bool = false
    var minus: Bool = false
    var home: Bool = false
    var one: Bool = false
    var two: Bool = false
    
    var player_id: Int = 1
    
    public func q(_ b: Bool){
        two = b
    }
    
    private init(){
        manager = SocketManager(socketURL: URL(string: "http://v-mac-mini.local:5000")!, config: [.log(true), .compress])
        socket = manager.defaultSocket
        
        socket.on(clientEvent: .connect) {data, ack in
            print("socket connected")
        }
        
        socket.on(clientEvent: .disconnect) {data, ack in
            print("socket connected")
        }
        
        socket.connect()
        
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
