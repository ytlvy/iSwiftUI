//
//  Figures.swift
//  iSwiftUI
//
//  Created by admin on 2023/7/8.
//

import Foundation
import SwiftUI

struct ChartModel: Identifiable {
  var id = UUID()
    
  var control1: CGPoint = CGPoint.zero
  var control2: CGPoint = CGPoint.zero
    
  var feed1: CGPoint = CGPoint.zero
  var feed2: CGPoint = CGPoint.zero
    
  var rectX: CGRect = CGRect.zero
}

final class Figures: ObservableObject {
  static var shared = Figures()
    
  var previous: Int = 0
    
  @Published var controls = ChartModel(control1: CGPoint(x: 128, y: 0), control2: CGPoint(x: 128, y: 0))
}
