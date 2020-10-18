//
//  phm.swift
//  wiirii
//
//  Created by Vasista Vovveti on 10/17/20.
//

import SwiftUI

struct phm: View {
    let sender: Sender = Sender.shared
    var body: some View {
        HStack{
            Circle()
                .foregroundColor(.primary)
                .overlay(Text("-").foregroundColor(Color(UIColor.secondarySystemBackground)).font(.title))
                .onLongPressGesture(minimumDuration: 1.0, maximumDistance: .infinity, pressing: { pressing in
                                    if pressing {
                                        sender.socket.emit("json", ["-": true])
                                    } else {
                                        sender.socket.emit("json", ["-": false])
                                    }
                                }, perform: { })
            Circle()
                .foregroundColor(.primary)
                .overlay(Text("home").foregroundColor(Color(UIColor.secondarySystemBackground)))
                .onLongPressGesture(minimumDuration: 1.0, maximumDistance: .infinity, pressing: { pressing in
                                    if pressing {
                                        sender.socket.emit("json", ["HOME": true])
                                    } else {
                                        sender.socket.emit("json", ["HOME": false])
                                    }
                                }, perform: { })
            Circle()
                .foregroundColor(.primary)
                .overlay(Text("+").foregroundColor(Color(UIColor.secondarySystemBackground)).font(.title))
                .onLongPressGesture(minimumDuration: 1.0, maximumDistance: .infinity, pressing: { pressing in
                                    if pressing {
                                        sender.socket.emit("json", ["+": true])
                                    } else {
                                        sender.socket.emit("json", ["+": false])
                                    }
                                }, perform: { })
        }
    }
}

struct phm_Previews: PreviewProvider {
    static var previews: some View {
        phm()
    }
}
