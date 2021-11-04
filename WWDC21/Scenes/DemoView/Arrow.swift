//
//  Arrow.swift
//  WWDC21
//
//  Created by Tomas Trujillo on 2021-11-02.
//

import SwiftUI

struct Arrow: Shape {
  enum Direction {
    case left
    case right
  }
  
  let direction: Direction
  
  func path(in rect: CGRect) -> Path {
    return direction == .left ? leftPath(in: rect) : rightPath(in: rect)
  }
  
  private func rightPath(in rect: CGRect) -> Path {
    var arrowPath = Path()
    arrowPath.move(to: CGPoint(x: 0, y: rect.height * 0.2))
    arrowPath.addLine(to: CGPoint(x: rect.width - rect.width * 0.5, y: rect.height * 0.2))
    arrowPath.addLine(to: CGPoint(x: rect.width - rect.width * 0.5, y: 0))
    arrowPath.addLine(to: CGPoint(x: rect.width, y: rect.height / 2))
    arrowPath.addLine(to: CGPoint(x: rect.width - rect.width * 0.5, y: rect.height))
    arrowPath.addLine(to: CGPoint(x: rect.width - rect.width * 0.5, y: rect.height - rect.height * 0.2))
    arrowPath.addLine(to: CGPoint(x: 0, y: rect.height - rect.height * 0.2))
    arrowPath.addLine(to: CGPoint(x: 0, y: rect.height * 0.2))
    return arrowPath
  }
  
  private func leftPath(in rect: CGRect) -> Path {
    var arrowPath = Path()
    arrowPath.move(to: CGPoint(x: 0.0, y: rect.height / 2))
    arrowPath.addLine(to: CGPoint(x: rect.width - rect.width * 0.5, y: 0))
    arrowPath.addLine(to: CGPoint(x: rect.width - rect.width * 0.5, y: rect.height * 0.2))
    arrowPath.addLine(to: CGPoint(x: rect.width, y: rect.height * 0.2))
    arrowPath.addLine(to: CGPoint(x: rect.width, y: rect.height - rect.height * 0.2))
    arrowPath.addLine(to: CGPoint(x: rect.width - rect.width * 0.5, y: rect.height - rect.height * 0.2))
    arrowPath.addLine(to: CGPoint(x: rect.width - rect.width * 0.5, y: rect.height))
    arrowPath.addLine(to: CGPoint(x: 0.0, y: rect.height / 2))
    
    return arrowPath
  }
}
