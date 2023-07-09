//
//  animateTest1.swift
//  iSwiftUI
//
//  Created by admin on 2023/7/6.
//

import Foundation
import SwiftUI

struct AnimateTest1 : View {
     
    var body: some View {
        
        testView2()
        
    }
    
}

let backgroundGradient = LinearGradient(
    colors: [Color.red, Color.blue],
    startPoint: .top, endPoint: .bottom)

struct testView2 :View {
    @State var _xOffset = 0.0
    @State var _isRed = false
    
    var body: some View {
        VStack{
            Circle()
                .fill(_isRed ? .red: .gray)
                .frame(width: 50, height: 50)
                .offset(x: _xOffset)
//                .animation(.easeOut(duration: 1), value: _xOffset)
//                .animation(.easeIn(duration: 2), value: _isRed)
            
            Button("click") { 
//                _isRed.toggle()
                withAnimation(.linear(duration: 1)) { 
                    if _xOffset == 0.0 {
                        _xOffset = 100
                    }
                    else {
                        _xOffset = 0.0
                    }
                }
                withAnimation(.easeOut(duration: 2)) {
                    _isRed.toggle()
                }
                
            }
        }
        .frame(width: 100, height: 100)
        .background(
            Circle()
                .fill(.mint)
        )
    }
}


struct testView1 :View {
    @State var _animated = false   
    var body: some View {
        VStack{
            VStack{
                Text("hello")
                    .font(.system(size: 20))
                    .offset(x: _animated ? 100: 0)
//                    .animation(.linear(duration: 1), value: _animated)
                //    .opacity(_animated ? 0 : 1)
                Text("word")
                    .offset(x: _animated ? 100 : 0)
                    .font(.system(.footnote))
            }
            .animation(.linear(duration: 1), value: _animated)
            .padding()
            
            Button { 
                _animated.toggle()
            } label: { 
                Text("click me")
            }
        }
    }
    
}


struct AnimateTest1_Previews: PreviewProvider {
    static var previews: some View {
        AnimateTest1()
    }
}
