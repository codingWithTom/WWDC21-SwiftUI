//
//  ExpandingShakingAnimation.swift
//  WWDC21
//
//  Created by Tomas Trujillo on 2021-11-11.
//

import SwiftUI

struct ExpandingShakingAnimation: GeometryEffect {
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
    if percent <= 0.8 {
      let relativePercent = percent / 0.5
      return scaleTransform(relativePercent, size: size)
    } else {
      let relativePercent = (percent - 0.5) / 0.5
      return shakingTransform(relativePercent, size: size)
    }
  }
  
  private func scaleTransform(_ percent: CGFloat, size: CGSize) -> ProjectionTransform {
    let anchorPointTransform = CGAffineTransform.init(translationX: -size.width / 2, y: -size.height / 2)
    let scaleTransform = anchorPointTransform.concatenating(.init(scaleX: 1.0 + 0.25 * percent, y: 1.0))
    return ProjectionTransform(scaleTransform)
      .concatenating(ProjectionTransform(.init(translationX: size.width / 2, y: size.height / 2)))
  }
  
  private func shakingTransform(_ percent: CGFloat, size: CGSize) -> ProjectionTransform {
    let anchorPointTransform = CGAffineTransform.init(translationX: -size.width / 2, y: -size.height / 2)
    var transform = CGAffineTransform.identity
    let maxSkew: CGFloat = 0.5
    if percent < 0.25 {
      transform.c = maxSkew * percent
    } else if percent < 0.5 {
      transform.c = -maxSkew * (percent - 0.25) / 0.25
    } else if percent < 0.75 {
      transform.c = maxSkew * (percent - 0.5) / 0.25 * 0.5
    } else {
      transform.c = -maxSkew * (percent - 0.75) / 0.25 * 0.5
    }
    return ProjectionTransform(anchorPointTransform.concatenating(transform))
      .concatenating(ProjectionTransform(.init(translationX: size.width / 2, y: size.height / 2)))
  }
}
