//
//  SnowEffect.swift
//  WWDC21
//
//  Created by Tomas Trujillo on 2021-11-29.
//

import SwiftUI

struct SnowEffect: ViewModifier {
  func body(content: Content) -> some View {
    let numberOfFlakes = 30
    let yPercents = (0 ..< numberOfFlakes).map { _ in CGFloat.random(in: 0 ... 1.0) }
    let xSigns = (0 ..< numberOfFlakes).map { _ in Bool.random() }
    
    content
      .overlay(
        TimelineView(.animation) { timeline in
          Canvas { context, size in
            let flakeSize = CGSize(
              width: size.width / CGFloat(numberOfFlakes),
              height: size.width / CGFloat(numberOfFlakes))
            let yOffset = timeline.date.timeIntervalSinceReferenceDate * size.height * 0.25
            (0 ..< numberOfFlakes).forEach { index in
              let xOffset = cos(timeline.date.timeIntervalSinceReferenceDate * 3) * flakeSize.width * CGFloat(xSigns[index] ? 1 : -1)
              let percent = CGFloat(index) / CGFloat(numberOfFlakes)
              let xCoordinate = percent * size.width + xOffset
              let yCoordinate = yPercents[index] * size.height + yOffset
              let point = CGPoint(x: xCoordinate,
                                  y: boundedYPosition(yCoordinate: yCoordinate, inSize: size))
              let fillRect = CGRect(
                origin: point,
                size: flakeSize)
                context.fill(Circle().path(in: fillRect), with: .color(.white))
            }
          }
        }
          .allowsHitTesting(false)
      )
  }
  
  private func boundedYPosition(yCoordinate: CGFloat, inSize size: CGSize) -> CGFloat {
    yCoordinate - CGFloat(Int(yCoordinate / size.height)) * size.height
  }
}

struct SnowEffect_Previews: PreviewProvider {
  static var previews: some View {
    Rectangle()
      .fill()
      .frame(width: 200, height: 200)
      .modifier(SnowEffect())
  }
}
