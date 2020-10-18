//
//  ContentView.swift
//  wiirii
//
//  Created by Vasista Vovveti on 10/17/20.
//

import SwiftUI

struct ContentView: View {
    @State var alignment = HorizontalAlignment.center;
    @State var connectionHeight: CGFloat = 0
    @State var dpadSize: CGFloat = 1e99
    
    var body: some View {
        VStack(alignment: alignment) {
            HStack {
                connection()
                    .frame(height: connectionHeight)
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
                .overlay(RetrieveDimension(dim: .height, into: $connectionHeight, when: .always))
            }

            Spacer()
            
            dpad()
                .frame(maxWidth: min(dpadSize, 233), maxHeight: min(dpadSize, 233))
                .overlay(RetrieveDimension(dim: .height, into: $dpadSize, when: .dimIsSmaller))
                .overlay(RetrieveDimension(dim: .width, into: $dpadSize, when: .dimIsSmaller))
            Abutton()
                .frame(maxHeight: 100)
            phm()
                .frame(maxHeight: 60)
            onetwo()
                .frame(maxWidth: 60, maxHeight: 150)
            
        }
        .padding()
        .animation(.easeInOut)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
            ContentView()
            ContentView()
        }
    }
}
