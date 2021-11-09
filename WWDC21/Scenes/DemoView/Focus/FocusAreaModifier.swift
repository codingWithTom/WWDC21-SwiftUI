//
//  FocusAreaModifier.swift
//  WWDC21
//
//  Created by Tomas Trujillo on 2021-11-02.
//

import SwiftUI
import Combine

enum FocusPosition {
  case left
  case right
}

struct FocusAreaModifier: ViewModifier {
  enum ArrowAnimation {
    case pulsating
    case backAndForth
    case backAndForthPulsating
  }
  
  @StateObject private var viewModel = GlobalFocusAreaViewModel()
  
  func body(content: Content) -> some View {
    ZStack(alignment: .focusAlignment) {
      content
      
      if viewModel.isShowingArrow {
        Arrow(direction: viewModel.focusPosition == .left ? .right : .left)
          .fill(.blue)
          .frame(width: 50, height: 50)
          .overlay(
            Arrow(direction: viewModel.focusPosition == .left ? .right : .left)
              .stroke(Color.black, lineWidth: 2.0)
          )
          .ifModifier(condition: viewModel.arrowAnimation == .backAndForthPulsating) { view in
            view.modifier(BackAndForthPulsatingAnimation(isOn: viewModel.isAnimating))
          }
          .ifModifier(condition: viewModel.arrowAnimation == .pulsating) { view in
            view.modifier(PulsatingAnimation(isOn: viewModel.isAnimating))
          }
          .ifModifier(condition: viewModel.arrowAnimation == .backAndForth) { view in
            view.modifier(BackAndForthAnimation(isOn: viewModel.isAnimating))
          }
          .animation(.linear(duration: 2.0).repeatForever(autoreverses: false), value: viewModel.isAnimating)
      }
    }
    .environmentObject(viewModel)
  }
}

final class GlobalFocusAreaViewModel: ObservableObject {
  private var currentFocusId = CurrentValueSubject<String, Never>("")
  var currentFocusPublisher: AnyPublisher<String, Never> {
    currentFocusId.eraseToAnyPublisher()
  }
  @Published var isShowingArrow: Bool = false
  @Published var focusPosition: FocusPosition = .left
  @Published var isAnimating: Bool = false
  @Published var arrowAnimation: FocusAreaModifier.ArrowAnimation = .backAndForth
  private var showingArrowForFocusWithId: String?
  
  
  func didChangeValue(_ value: Bool, forFocusWithID id: String, position: FocusPosition, animation: FocusAreaModifier.ArrowAnimation) {
    if value {
      currentFocusId.value = id
      isShowingArrow = true
      showingArrowForFocusWithId = id
      focusPosition = position
      arrowAnimation = animation
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
        self?.isAnimating.toggle()
      }
      
    } else {
      if showingArrowForFocusWithId == id {
        isShowingArrow = false
        isAnimating = false
        showingArrowForFocusWithId = nil
      }
    }
  }
}
