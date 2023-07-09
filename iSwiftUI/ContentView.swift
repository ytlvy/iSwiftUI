//
//  ContentView.swift
//  iSwiftUI
//
//  Created by admin on 2023/7/5.
//

import SwiftUI

struct ContentView: View {
    @State var animate = false
    var body: some View {
        VStack {
            Text("中国好是的水电费水电费水电费手打水电费水电费水电费水电费水电费")
                .font(.system(size: 20))
                .multilineTextAlignment(.trailing)
                .mask(
                    LinearGradient(colors: [.red.opacity(0.1), .gray.opacity(0.6)], startPoint:.top, endPoint:.bottom)
                )
                .frame(maxWidth: .infinity)
                .padding()
                .offset(x: animate ? 0 : 200)
                .animation(.easeIn, value: animate)
                .onAppear{
                    animate.toggle()
                }
            
            
                
//            Rectangle()
//                .fill(
//                    LinearGradient(colors: [.red.opacity(0.1), .gray.opacity(0.6)], startPoint:.leading, endPoint:.trailing)
//                )
//                .frame(maxWidth: .infinity)
//                .mask(Text("中国好是的水电费水电费水电费手打水电费水电费水电费水电费水电费"))
//                .padding()
        }
        .fixedSize(horizontal: true, vertical: false)
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
