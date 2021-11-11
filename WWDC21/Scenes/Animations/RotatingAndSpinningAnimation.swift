//
//  RotatingAndSpinningAnimation.swift
//  WWDC21
//
//  Created by Tomas Trujillo on 2021-11-09.
//

import SwiftUI

struct RotatingAndSpinningAnimation: GeometryEffect {
  private var percent: CGFloat
  var animatableData: CGFloat {
    get { percent }
    set { percent = newValue }
  }
  
  init(isOn: Bool) {
    self.percent = isOn ? 1.0 : 0.0
  }

  func effectValue(size: CGSize) -> ProjectionTransform {
    guard percent >= 0.1, percent <= 0.9 else { return ProjectionTransform(.identity) }
    let realPercent = (percent - 0.1) / 0.8
    let rotationTransform = CGAffineTransform(rotationAngle: -2 * .pi * realPercent)
    let spinningTransform = CGAffineTransform(rotationAngle: -4 * .pi * realPercent)
    var transform = CGAffineTransform(translationX: -size.width / 2, y: -size.height / 2)
    transform = transform.concatenating(spinningTransform)
    let anchorPointTransform = CGAffineTransform(translationX: size.width / 2, y: size.height / 2)
    return ProjectionTransform(transform)
      .concatenating(ProjectionTransform(anchorPointTransform))
      .concatenating(ProjectionTransform(rotationTransform))
  }
}
