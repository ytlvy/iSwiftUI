//
//  Button.swift
//  iSwiftUI
//
//  Created by admin on 2023/7/22.
//

import Foundation
import SwiftUI


struct ButtonTestView:View {
    var body: some View{
        let label = Label("Press Me", systemImage: "digitalcrown.horizontal.press.fill")
        RoundedAndShadowButton(label: label) { 
            let _ = print("Button clicked")
        }
    }
}

struct RoundedAndShadowButton<V>:View where V:View {
    let label:V
    let action: () -> Void
    
    init(label: V, action: @escaping ()->Void) {
        self.label = label
        self.action = action
    }
    
    var body: some View {
        Button {
            action()
        } label: {
            label
                .foregroundColor(.white)
                .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(.blue)
                )
                .compositingGroup()
//                .shadow(radius: 5, x:0, y:3)
//                .contentShape(Rectangle()) 
        }
        .buttonStyle(.plain)
    }
}

struct ButtonTestView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonTestView()
    }
}











