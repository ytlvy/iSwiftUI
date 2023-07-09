//
//  List.swift
//  iSwiftUI
//
//  Created by admin on 2023/7/8.
//

import Foundation
import SwiftUI

struct ListTest : View {
    
    struct OceanModel : Identifiable {
        let name: String
        let id = UUID()
    }
    
    private var oceans = [
        OceanModel(name: "Pacific"),
        OceanModel(name: "Atlantic"),
        OceanModel(name: "Indian"),
        OceanModel(name: "Southern"),
        OceanModel(name: "Arctic"),
    ]
    
    var body: some View {
        List(oceans) {
            Text($0.name)
        }
    } 
}

struct ListTest_Previews: PreviewProvider {
    static var previews: some View {
        ListTest()
    }
}
