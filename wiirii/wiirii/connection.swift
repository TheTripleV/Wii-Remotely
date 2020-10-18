//
//  connection.swift
//  wiirii
//
//  Created by Vasista Vovveti on 10/18/20.
//

import SwiftUI

struct connection: View {
    @ObservedObject var sender: Sender = .shared
    let circle_radius: CGFloat = 5
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                HStack{
                    Circle()
                        .frame(width: circle_radius)
                }
                .foregroundColor(Color(UIColor.secondarySystemBackground))
                .frame(maxWidth: .infinity)
                HStack{
                    Circle().frame(width: circle_radius)
                    Circle().frame(width: circle_radius)
                }
                .foregroundColor(Color(UIColor.secondarySystemBackground))
                .frame(maxWidth: .infinity)
                HStack {
                    Circle().frame(width: circle_radius)
                    Circle().frame(width: circle_radius)
                    Circle().frame(width: circle_radius)
                }
                .foregroundColor(Color(UIColor.secondarySystemBackground))
                .frame(maxWidth: .infinity)
                HStack {
                    Circle().frame(width: circle_radius)
                    Circle().frame(width: circle_radius)
                    Circle().frame(width: circle_radius)
                    Circle().frame(width: circle_radius)
                }
                .foregroundColor(Color(UIColor.secondarySystemBackground))
                .frame(maxWidth: .infinity)
            }
            .frame(height: circle_radius * 2)
            
            HStack {
                GeometryReader { proxy in
                    Rectangle()
                        .foregroundColor(sender.player_id == 1 ? .blue : Color(UIColor.secondarySystemBackground))
                        .onTapGesture(perform: {
                            var pid = sender.player_id + 1
                            if pid == 5 {
                                pid = 1
                            }
                            sender.objectWillChange.send()
                            sender.player_id = pid
                        })
                        .frame(maxWidth: min(proxy.size.width, proxy.size.height), maxHeight: min(proxy.size.width, proxy.size.height))
                }
                .padding(.leading)
                .padding(.trailing)
                GeometryReader { proxy in
                    Rectangle()
                        .foregroundColor(sender.player_id == 2 ? .blue : Color(UIColor.secondarySystemBackground))
                        .onTapGesture(perform: {
                            var pid = sender.player_id + 1
                            if pid == 5 {
                                pid = 1
                            }
                            sender.objectWillChange.send()
                            sender.player_id = pid
                        })
                        .frame(maxWidth: min(proxy.size.width, proxy.size.height), maxHeight: min(proxy.size.width, proxy.size.height))
                }
                .padding(.leading)
                .padding(.trailing)
                GeometryReader { proxy in
                    Rectangle()
                        .foregroundColor(sender.player_id == 3 ? .blue : Color(UIColor.secondarySystemBackground))
                        .onTapGesture(perform: {
                            var pid = sender.player_id + 1
                            if pid == 5 {
                                pid = 1
                            }
                            sender.objectWillChange.send()
                            sender.player_id = pid
                        })
                        .frame(maxWidth: min(proxy.size.width, proxy.size.height), maxHeight: min(proxy.size.width, proxy.size.height))
                }
                .padding(.leading)
                .padding(.trailing)
                GeometryReader { proxy in
                    Rectangle()
                        .foregroundColor(sender.player_id == 4 ? .blue : Color(UIColor.secondarySystemBackground))
                        .onTapGesture(perform: {
                            var pid = sender.player_id + 1
                            if pid == 5 {
                                pid = 1
                            }
                            sender.objectWillChange.send()
                            sender.player_id = pid
                        })
                        .frame(maxWidth: min(proxy.size.width, proxy.size.height), maxHeight: min(proxy.size.width, proxy.size.height))
                }
                .padding(.leading)
                .padding(.trailing)
                
            }
        }
    }
}

struct connection_Previews: PreviewProvider {
    static var previews: some View {
        connection()
    }
}
