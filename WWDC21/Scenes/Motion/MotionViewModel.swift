//
//  MotionViewModel.swift
//  MotionViewModel
//
//  Created by Tomas Trujillo on 2021-08-08.
//

import UIKit

final class MotionViewModel: ObservableObject {
  @Published var isAnimating: Bool = false
  @Published var offset: CGSize = .zero
  private var isMonitoringMotion: Bool = false
  var motionService: MotionService = MotionServiceAdater.shared
  
  func tappedAnimate() {
    isAnimating.toggle()
    offset = .zero
  }
  
  func tappedToggleMotion() {
    if isMonitoringMotion {
      motionService.stopStream()
    } else {
      startMonitoring()
    }
    isAnimating = false
    isMonitoringMotion.toggle()
  }
  
  private func startMonitoring() {
    let stream = motionService.getStream()
    Task {
      for await (x, y) in stream {
        await self.updateOffset(x: x, y: y)
      }
    }
  }
  
  @MainActor
  private func updateOffset(x: Double, y: Double) {
    offset.width += x * 5
    offset.height -= y * 5
  }
}
