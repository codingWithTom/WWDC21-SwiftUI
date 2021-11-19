//
//  SplitEffect.swift
//  WWDC21
//
//  Created by Tomas Trujillo on 2021-11-17.
//

import SwiftUI

struct SplitEffect: GeometryEffect {
  private var percent: CGFloat
  var animatableData: CGFloat {
    get { percent }
    set { percent = newValue }
  }
  private let corner: Corner
  
  init(isOn: Bool, corner: Corner) {
    self.percent = isOn ? 1.0 : 0.0
    self.corner = corner
  }
  
  func effectValue(size: CGSize) -> ProjectionTransform {
    guard percent != 0, percent != 1 else { return ProjectionTransform(.identity) }
    let transform: CGAffineTransform
    if percent <= 0.25 {
      let relativePercent = percent / 0.25
      transform = .init(translationX: horizontalDisplacement(size: size) * relativePercent,
                        y: verticalDisplacement(size: size) * relativePercent)
    } else if percent <= 0.75 {
      transform = .init(translationX: horizontalDisplacement(size: size),
                        y: verticalDisplacement(size: size))
    } else {
      let relativePercent = (percent - 0.75) / 0.25
      let xTranslation = horizontalDisplacement(size: size)
      let yTranslation = verticalDisplacement(size: size)
      transform = .init(translationX: xTranslation - xTranslation * relativePercent,
                        y: yTranslation - yTranslation * relativePercent)
    }
    return ProjectionTransform(transform)
  }
  
  private func horizontalDisplacement(size: CGSize) -> CGFloat {
    switch corner {
    case .topRight, .bottomRight:
      return size.width / 4
    case .topLeft, .bottomLeft:
      return -size.width / 4
    }
  }
  
  private func verticalDisplacement(size: CGSize) -> CGFloat {
    switch corner {
    case .topRight, .topLeft:
      return -size.height / 4
    case .bottomRight, .bottomLeft:
      return size.height / 4
    }
  }
}
