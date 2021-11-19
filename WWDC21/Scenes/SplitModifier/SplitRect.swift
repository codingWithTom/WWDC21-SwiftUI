//
//  SplitRect.swift
//  WWDC21
//
//  Created by Tomas Trujillo on 2021-11-17.
//

import SwiftUI

struct SplitRect: Shape {
  let corner: Corner
  
  func path(in rect: CGRect) -> Path {
    var path = Path()
    
    switch corner {
    case .topRight:
      path.move(to: .init(x: rect.width / 2, y: 0.0))
      path.addLine(to: .init(x: rect.width, y: 0.0))
      path.addLine(to: .init(x: rect.width, y: rect.height / 2))
      path.addLine(to: .init(x: rect.width / 2, y: rect.height / 2))
      path.closeSubpath()
    case .topLeft:
      path.move(to: .init(x: 0.0, y: 0.0))
      path.addLine(to: .init(x: rect.width / 2, y: 0.0))
      path.addLine(to: .init(x: rect.width / 2, y: rect.height / 2))
      path.addLine(to: .init(x: 0.0, y: rect.height / 2))
      path.closeSubpath()
    case .bottomRight:
      path.move(to: .init(x: rect.width / 2, y: rect.height / 2))
      path.addLine(to: .init(x: rect.width, y: rect.height / 2))
      path.addLine(to: .init(x: rect.width, y: rect.height))
      path.addLine(to: .init(x: rect.width / 2, y: rect.height))
      path.closeSubpath()
    case .bottomLeft:
      path.move(to: .init(x: 0.0, y: rect.height / 2))
      path.addLine(to: .init(x: rect.width / 2, y: rect.height / 2))
      path.addLine(to: .init(x: rect.width / 2, y: rect.height))
      path.addLine(to: .init(x: 0.0, y: rect.height))
      path.closeSubpath()
    }
    
    return path
  }
}
