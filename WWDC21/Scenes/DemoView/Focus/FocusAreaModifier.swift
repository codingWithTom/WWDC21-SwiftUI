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
  @StateObject private var viewModel = GlobalFocusAreaViewModel()
  
  func body(content: Content) -> some View {
    ZStack(alignment: .focusAlignment) {
      content
      
      if viewModel.isShowingArrow {
        Arrow(direction: viewModel.focusPosition == .left ? .right : .left)
          .frame(width: 50, height: 50)
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
  private var showingArrowForFocusWithId: String?
  
  
  func didChangeValue(_ value: Bool, forFocusWithID id: String, position: FocusPosition) {
    if value {
      currentFocusId.value = id
      isShowingArrow = true
      showingArrowForFocusWithId = id
      focusPosition = position
    } else {
      if showingArrowForFocusWithId == id {
        isShowingArrow = false
        showingArrowForFocusWithId = nil
      }
    }
  }
}
