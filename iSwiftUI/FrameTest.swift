//
//  FrameTest.swift
//  iSwiftUI
//
//  Created by admin on 2023/7/24.
//

import Foundation
import SwiftUI

struct FrameTestView : View {
    var body: some View {
        SquareView()
    }
}

struct SquareView: View {
    @State private var width: CGFloat = 150
    @State private var fixedSize: Bool = true
    
    var body: some View {
        GeometryReader { proxy in
            
            VStack {
                Spacer()
                
                VStack {
                    LittleSquares(total: 7)
                        .border(Color.green)
                        .fixedSize(horizontal: self.fixedSize, vertical: false)
                }
                .frame(width: self.width)
                .border(Color.primary)
                .background(MyGradient())
                
                Spacer()
                
                Form {
                    Slider(value: self.$width, in: 0...proxy.size.width)
                    Toggle(isOn: self.$fixedSize) { Text("Fixed Width") }
                }
            }
        }.padding(.top, 140)
    }
}

struct LittleSquares: View {
    let sqSize: CGFloat = 20
    let total: Int
    
    var body: some View {
        GeometryReader { proxy in
            HStack(spacing: 5) {
                ForEach(0..<self.maxSquares(proxy), id: \.self) { _ in
                    RoundedRectangle(cornerRadius: 5)
                        .frame(width: self.sqSize, height: self.sqSize)
                        .foregroundColor(self.allFit(proxy) ? .green : .red)
                }
            }
        }
        .frame(idealWidth: _idealWidth(), maxWidth: _idealWidth())
    }
    
    func _idealWidth() -> CGFloat {
        (5 + self.sqSize) * CGFloat(self.total)
    }

    func maxSquares(_ proxy: GeometryProxy) -> Int {
        return min(Int(proxy.size.width / (sqSize + 5)), total)
    }
    
    func allFit(_ proxy: GeometryProxy) -> Bool {
        return maxSquares(proxy) == total
    }
}

struct MyGradient: View {
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [Color.red.opacity(0.1), Color.green.opacity(0.1)]), startPoint: UnitPoint(x: 0, y: 0), endPoint: UnitPoint(x: 1, y: 1))
    }
}

struct TextTest : View {
    @State private var _width = 200.0
    var body: some View {
        VStack(alignment: .center){
            Text("jsljdlsjdlfjsldjlfsjdjfsldfsdfsdf")
//                .fixedSize()
                .border(Color.black)
                .frame(width: _width, height: 100)
                .border(Color.red)
                .font(.title)
            
            Slider(value:$_width, in: 0...1000, step: 2)
        }
    }
}

struct ExampleView : View {
    @State private var _width = 50.0
    
    var body: some View {
        VStack(alignment: .center){
            SubView()
                .frame(width: _width, height: 120)
                .border(Color.blue, width: 2)
            
            Text("offerd Width: \(_width)")
            Slider(value: $_width, in: 0...200, step: 1)
        }
    }
}

struct SubView : View {
    var body: some View {
        GeometryReader { proxy in
            Rectangle()
                .fill(Color.yellow.opacity(0.7))
                .frame(width: max(proxy.size.width, 120), height: max(proxy.size.height, 120))
        }
    }
}

struct FrameTestView_Previews: PreviewProvider {
    static var previews: some View {
        FrameTestView()
    }
}
