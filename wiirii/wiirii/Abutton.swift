//
//  Abutton.swift
//  wiirii
//
//  Created by Vasista Vovveti on 10/17/20.
//

import SwiftUI

struct Abutton: View {
    let sender: Sender = Sender.shared
    var body: some View {
        HStack {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
//                .foregroundColor(.gray)
                .overlay(
                    Text("B")
                        .font(.title)
                        .foregroundColor(Color(UIColor.secondarySystemBackground))
                )
                .onLongPressGesture(minimumDuration: 1.0, maximumDistance: .infinity, pressing: { pressing in
                                    if pressing {
                                        sender.socket.emit("json", ["B": true])
                                    } else {
                                        sender.socket.emit("json", ["B": false])
                                    }
                                }, perform: { })
            Circle()
                .foregroundColor(.gray)
                .overlay(
                    Text("A")
                        .font(.title)
                        .foregroundColor(.white)
                )
                .onLongPressGesture(minimumDuration: 1.0, maximumDistance: .infinity, pressing: { pressing in
                                    if pressing {
                                        sender.socket.emit("json", ["A": true])
                                    } else {
                                        sender.socket.emit("json", ["A": false])
                                    }
                                }, perform: { })
            
            RoundedRectangle(cornerRadius: 20, style: .continuous)
//                .foregroundColor(.gray)
                .overlay(
                    Text("B")
                        .font(.title)
                        .foregroundColor(Color(UIColor.secondarySystemBackground))
                )
                .onLongPressGesture(minimumDuration: 1.0, maximumDistance: .infinity, pressing: { pressing in
                                    if pressing {
                                        sender.socket.emit("json", ["B": true])
                                    } else {
                                        sender.socket.emit("json", ["B": false])
                                    }
                                }, perform: { })
        }
    }
}

struct Abutton_Previews: PreviewProvider {
    static var previews: some View {
        Abutton()
    }
}
