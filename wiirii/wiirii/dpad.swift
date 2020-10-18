//
//  dpad.swift
//  wiirii
//
//  Created by Vasista Vovveti on 10/17/20.
//

import SwiftUI

struct dpad: View {
    let sender: Sender = Sender.shared
    var body: some View {
        VStack(spacing: 0){
            HStack(spacing: 0){
                Rectangle().foregroundColor(.clear)
                Rectangle().foregroundColor(.primary).overlay(Text("|").foregroundColor(Color(UIColor.secondarySystemBackground)).font(.title))
                    .onLongPressGesture(minimumDuration: 1.0, maximumDistance: .infinity, pressing: { pressing in
                                        if pressing {
                                            sender.socket.emit("buttons", ["id": sender.player_id, "DPAD_UP": true])
                                        } else {
                                            sender.socket.emit("buttons", ["id": sender.player_id, "DPAD_UP": false])
                                        }
                                    }, perform: { })
                Rectangle().foregroundColor(.clear)
            }
            HStack(spacing: 0){
                Rectangle().foregroundColor(.primary).overlay(Text("|").foregroundColor(Color(UIColor.secondarySystemBackground)).font(.title).rotationEffect(.degrees(90)))
                    .onLongPressGesture(minimumDuration: 1.0, maximumDistance: .infinity, pressing: { pressing in
                                        if pressing {
                                            sender.socket.emit("buttons", ["id": sender.player_id, "DPAD_LEFT": true])
                                        } else {
                                            sender.socket.emit("buttons", ["id": sender.player_id, "DPAD_LEFT": false])
                                        }
                                    }, perform: { })
                Rectangle().foregroundColor(.primary)
                Rectangle().foregroundColor(.primary).overlay(Text("|").foregroundColor(Color(UIColor.secondarySystemBackground)).font(.title).rotationEffect(.degrees(90)))
                    .onLongPressGesture(minimumDuration: 1.0, maximumDistance: .infinity, pressing: { pressing in
                                        if pressing {
                                            sender.socket.emit("buttons", ["id": sender.player_id, "DPAD_RIGHT": true])
                                        } else {
                                            sender.socket.emit("buttons", ["id": sender.player_id, "DPAD_RIGHT": false])
                                        }
                                    }, perform: { })
            }
            HStack(spacing: 0){
                Rectangle().foregroundColor(.clear)
                Rectangle().foregroundColor(.primary).overlay(Text("|").foregroundColor(Color(UIColor.secondarySystemBackground)).font(.title))
                    .onLongPressGesture(minimumDuration: 1.0, maximumDistance: .infinity, pressing: { pressing in
                                        if pressing {
                                            sender.socket.emit("buttons", ["id": sender.player_id, "DPAD_DOWN": true])
                                        } else {
                                            sender.socket.emit("buttons", ["id": sender.player_id, "DPAD_DOWN": false])
                                        }
                                    }, perform: { })
                Rectangle().foregroundColor(.clear)
            }
        }
        .padding(.top)
        .padding(.bottom)
//        VStack(spacing: 0){
//            HStack(spacing: 0){
//                Rectangle().foregroundColor(.clear)
//                RoundedRectangle(cornerRadius: 20, style: .continuous).foregroundColor(.primary)
//                Rectangle().foregroundColor(.clear)
//            }
//            HStack(spacing: 0){
//                RoundedRectangle(cornerRadius: 20, style: .continuous).foregroundColor(.primary)
//                Rectangle().foregroundColor(.clear)
//                RoundedRectangle(cornerRadius: 20, style: .continuous).foregroundColor(.primary)
//            }
//            HStack(spacing: 0){
//                Rectangle().foregroundColor(.clear)
//                RoundedRectangle(cornerRadius: 20, style: .continuous).foregroundColor(.primary)
//                Rectangle().foregroundColor(.clear)
//            }
//        }
//        .padding()
    }
}

struct dpad_Previews: PreviewProvider {
    static var previews: some View {
        dpad()
    }
}
