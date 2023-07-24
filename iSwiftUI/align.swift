//
//  align.swift
//  iSwiftUI
//
//  Created by admin on 2023/7/18.
//

import Foundation
import SwiftUI

struct AlignTestView: View {
    var hello : some View {
        Text("Hello worldsdfsdfsdfsdfsdfdsfsdfsdfsdf")
            .foregroundColor(.white)
            .font(.title)
            .lineLimit(1)
            
    }
    
    var topTest : some View {
        VStack{
            HStack {
                Spacer(minLength: 0)
                hello
                Spacer(minLength: 0)
            }
            .frame(width: 300, height: 60)
            .background(.blue, ignoresSafeAreaEdges:  [])
            .cornerRadius(5)
            
            HStack {
                Spacer(minLength: 0)
                hello
                Spacer(minLength: 0)
            }
            .frame(width: 300, height: 60)
            .background(.gray)
            
            Spacer()
        }
    }
    
    var body: some View {
        List {
            ForEach((0...1000).map{$0}, id: \.self) { id in
                HStack{
                    Spacer()
                    hello
                    Spacer()
                }
                .background(.blue)
                .listRowInsets(.init(top: 0, leading: 10, bottom: 0, trailing: 10))
                .onTapGesture {
                    let _ = print("clicked \(id)")
                }
            }
        }
        .listStyle(.plain)
        .environment(\.defaultMinListRowHeight, 80)
        
    }
    
}


struct AlignTestView_Previews: PreviewProvider {
    static var previews: some View {
        AlignTestView()
    }
}

