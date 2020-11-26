//
//  ContentView.swift
//  iSwiftUI
//
//  Created by yanjie guo on 2020/11/26.
//

import SwiftUI

struct ContentView: View {
    
    let rTarget = Double.random(in: 0..<1)
    let gTarget = Double.random(in: 0..<1)
    let bTarget = Double.random(in: 0..<1)
    
    @State var rGuess: Double
    @State var gGuess: Double
    @State var bGuess: Double
    
    var body: some View {
        VStack {
            HStack {
                VStack {
                    Color(red: rTarget, green: gTarget, blue: bTarget)
                    Text("Match this color")
                }
                
                VStack {
                    Color(red: rGuess, green: gGuess, blue: bGuess)
                    Text("R: \(Int(rGuess*255)) G:\(Int(gGuess*255)) B: \(Int(bGuess*255))")
                }
            }
            Button(action: {}, label: {
                Text("Hit Me!")
            })
            VStack {
                ColorSlider(value:$rGuess, textColor:.red)
                ColorSlider(value:$gGuess, textColor:.green)
                ColorSlider(value:$bGuess, textColor:.blue)

            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(rGuess: 0.8, gGuess: 0.5, bGuess: 0.5)
    }
}

struct ColorSlider: View {
    @Binding var value: Double
    var textColor: Color
    
    var body: some View {
        HStack {
            Text("0").foregroundColor(textColor)
            Slider(value: $value).accentColor(textColor)
            Text("255").foregroundColor(textColor)
        }.padding(.horizontal)
    }
}
