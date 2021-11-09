//
//  PulsatingAnimation.swift
//  WWDC21
//
//  Created by Tomas Trujillo on 2021-11-07.
//

import SwiftUI

struct PulsatingAnimation: GeometryEffect {
  
  private var percent: CGFloat
  var animatableData: CGFloat {
    get { percent }
    set { percent = newValue }
  }
  
  init(isOn: Bool) {
    self.percent = isOn ? 1.0 : 0.0
  }
  
  func effectValue(size: CGSize) -> ProjectionTransform {
    guard percent != 0, percent != 1 else { return ProjectionTransform(.identity) }
    let transform = Self.transform(forPercent: percent, size: size)
    return ProjectionTransform(transform)
  }
  
  static func transform(forPercent percent: CGFloat, size: CGSize) -> CGAffineTransform {
    let transform: CGAffineTransform
    if percent < 0.25 {
      transform = .init(scaleX: 1.0 + percent, y: 1.0 + percent)
    } else if percent < 0.5 {
      transform = .init(scaleX: 1.25 - (percent - 0.25), y: 1.25 - (percent - 0.25))
    } else if percent < 0.75 {
      transform = .init(scaleX: 1.0 - (percent - 0.5), y: 1.0 - (percent - 0.5))
    } else {
      transform = .init(scaleX: percent, y: percent)
    }
    return transform
  }
}
