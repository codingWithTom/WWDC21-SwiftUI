//
//  WheelAnimation.swift
//  WWDC21
//
//  Created by Tomas Trujillo on 2021-11-09.
//

import SwiftUI

struct WheelAnimation: GeometryEffect {
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
    var transform = CGAffineTransform(translationX: -size.width / 2, y: -size.height / 2)
    transform = transform.concatenating(.init(rotationAngle: -6 * .pi * percent))
    let anchorPointTransform = CGAffineTransform(translationX: size.width / 2, y: size.height / 2)
    let translationTransform: CGAffineTransform
    if percent < 0.5 {
      translationTransform = .init(translationX: size.width / 2 * percent / 0.5, y: 0.0)
    } else {
      translationTransform = .init(translationX: size.width / 2 - (size.width / 2 * (percent - 0.5) / 0.5), y: 0.0)
    }
    return ProjectionTransform(transform)
      .concatenating(ProjectionTransform(anchorPointTransform))
      .concatenating(ProjectionTransform(translationTransform))
  }
}
