//
//  MotionService.swift
//  MotionService
//
//  Created by Tomas Trujillo on 2021-08-08.
//

import Foundation
import CoreMotion

protocol MotionService {
  func getStream() -> AsyncStream<(Double, Double)>
  func stopStream()
}

final class MotionServiceAdater: MotionService {
  static let shared = MotionServiceAdater()
  private let motionManager = CMMotionManager()
  private var streamContinuation: AsyncStream<(Double, Double)>.Continuation?
  
  private init() { }
  
  func getStream() -> AsyncStream<(Double, Double)> {
    return AsyncStream<(Double, Double)> { continuation in
      continuation.onTermination = { @Sendable [weak self] _ in self?.stopMonitoring() }
      self.streamContinuation = continuation
      Task.detached { [weak self] in
        self?.startMonitoring(with: continuation)
      }
    }
  }
  
  func stopStream() {
    streamContinuation?.finish()
    streamContinuation = nil
  }
  
  private func startMonitoring(with continuation: AsyncStream<(Double, Double)>.Continuation) {
    guard
      motionManager.isDeviceMotionAvailable,
      !motionManager.isDeviceMotionActive
    else { return }
    motionManager.startDeviceMotionUpdates(to: OperationQueue()) { motion, error in
      guard
        error == nil,
        let gravity = motion?.gravity
      else { return }
      continuation.yield((gravity.x, gravity.y))
      print("Gravity -----> (\(gravity.x), \(gravity.y), \(gravity.z) )")
    }
  }
  
  private func stopMonitoring() {
    guard
      motionManager.isDeviceMotionAvailable,
      motionManager.isDeviceMotionActive
    else { return }
    motionManager.stopDeviceMotionUpdates()
  }
}
