//
//  BackAndForthAnimation.swift
//  WWDC21
//
//  Created by Tomas Trujillo on 2021-11-07.
//

import SwiftUI

struct BackAndForthAnimation: GeometryEffect {
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
    let transform = Self.transform(forPercent: percent, size: size)
    return ProjectionTransform(transform)
  }
  
  static func transform(forPercent percent: CGFloat, size: CGSize) -> CGAffineTransform {
    let width: CGFloat = 25
    let transform: CGAffineTransform
    if percent < 0.25 {
      transform = .init(translationX: -width * (percent / 0.25), y: 1.0)
    } else if percent < 0.5 {
      transform = .init(translationX: -width + width * ((percent - 0.25) / 0.25), y: 1.0)
    } else if percent < 0.75 {
      transform = .init(translationX: width * ((percent - 0.5) / 0.25), y: 1.0)
    } else {
      transform = .init(translationX: width - width * ((percent - 0.75) / 0.25 ), y: 1.0)
    }
    return transform
  }
}
