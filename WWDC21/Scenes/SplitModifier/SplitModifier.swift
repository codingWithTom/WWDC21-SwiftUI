//
//  SplitModifier.swift
//  WWDC21
//
//  Created by Tomas Trujillo on 2021-11-17.
//

import SwiftUI

struct SplitModifier: ViewModifier {
  @State private var isTapped: Bool = false
  @State private var isAnimating: Bool = false
  let action: () -> Void
  
  func body(content: Content) -> some View {
    content
      .hidden()
      .overlay(
        ZStack {
          content
            .clipShape(SplitRect(corner: .topRight))
            .modifier(SplitEffect(isOn: isAnimating, corner: .topRight))
          content
            .clipShape(SplitRect(corner: .topLeft))
            .modifier(SplitEffect(isOn: isAnimating, corner: .topLeft))
          content
            .clipShape(SplitRect(corner: .bottomRight))
            .modifier(SplitEffect(isOn: isAnimating, corner: .bottomRight))
          content
            .clipShape(SplitRect(corner: .bottomLeft))
            .modifier(SplitEffect(isOn: isAnimating, corner: .bottomLeft))
        }
          .animation(.linear(duration: 1), value: isAnimating)
      )
      .onTapGesture {
        guard !isTapped else { return }
        isTapped = true
        withAnimation { isAnimating = true }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
          action()
        }
      }
  }
}
