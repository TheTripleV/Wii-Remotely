//
//  onetwo.swift
//  wiirii
//
//  Created by Vasista Vovveti on 10/17/20.
//

import SwiftUI

struct onetwo: View {
    let sender: Sender = Sender.shared

    var body: some View {
        VStack{
            Circle()
                .overlay(
                    Text("1")
                        .foregroundColor(Color(UIColor.secondarySystemBackground))
                        .font(.title)
                )
                .onLongPressGesture(minimumDuration: 1.0, maximumDistance: .infinity, pressing: { pressing in
                                    if pressing {
                                        sender.socket.emit("buttons", ["id": sender.player_id, "1": true])
                                    } else {
                                        sender.socket.emit("buttons", ["id": sender.player_id, "1": false])
                                    }
                                }, perform: { })
            Circle()
                .overlay(Text("2")
                            .foregroundColor(Color(UIColor.secondarySystemBackground))
                            .font(.title)
                )
                .onLongPressGesture(minimumDuration: 1.0, maximumDistance: .infinity, pressing: { pressing in
                                    if pressing {
                                        sender.socket.emit("buttons", ["id": sender.player_id, "2": true])
                                    } else {
                                        sender.socket.emit("buttons", ["id": sender.player_id, "2": false])
                                    }
                                }, perform: { })

        }
    }
}

struct onetwo_Previews: PreviewProvider {
    static var previews: some View {
        onetwo()
    }
}
