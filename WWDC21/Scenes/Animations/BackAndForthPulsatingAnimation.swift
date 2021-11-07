//
//  BackAndForthPulsatingAnimation.swift
//  WWDC21
//
//  Created by Tomas Trujillo on 2021-11-07.
//

import SwiftUI

struct BackAndForthPulsatingAnimation: GeometryEffect {
  private var percent: CGFloat
  var animatableData: CGFloat {
    get { percent }
    set { percent = newValue }
  }
  
  init(isOn: Bool) {
    self.percent = isOn ? 1.0 : 0.0
  }
  
  func effectValue(size: CGSize) -> ProjectionTransform {
    guard percent != 0.0, percent != 1.0 else { return ProjectionTransform(.identity) }
    let transform: CGAffineTransform
    if percent < 0.5 {
      transform = BackAndForthAnimation.transform(forPercent: percent / 0.5, size: size)
    } else {
      transform = PulsatingAnimation.transform(forPercent: (percent - 0.5) / 0.5, size: size)
    }
    return ProjectionTransform(transform)
  }
}
