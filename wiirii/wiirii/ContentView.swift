//
//  ContentView.swift
//  wiirii
//
//  Created by Vasista Vovveti on 10/17/20.
//

import SwiftUI

struct ContentView: View {
    @State var alignment = HorizontalAlignment.center;
    
    var body: some View {
        VStack(alignment: alignment) {
            HStack {
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(maxWidth:.infinity)
                    .frame(maxHeight: 0)
                Button(action: {
                    if (alignment == .center) {
                        alignment = .trailing
                    }
                    else if (alignment == .trailing) {
                        alignment = .leading
                    }
                    else {
                        alignment = .center
                    }
                }) {
                    Text("alignment")
                        .padding()
                }
                .foregroundColor(Color(UIColor.secondarySystemBackground))
                .background(Color.primary)
            }

            Spacer()
            
            dpad()
                .frame(maxWidth: 300, maxHeight: 300)
            Abutton()
                .frame(maxHeight: 100)
            phm()
                .frame(maxHeight: 60)
            onetwo()
                .frame(maxWidth: 80, maxHeight: 200)
            
        }
        .padding()
        .animation(.easeInOut)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
