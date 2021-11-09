//
//  FocusModifier.swift
//  WWDC21
//
//  Created by Tomas Trujillo on 2021-11-02.
//

import SwiftUI
import Combine

struct FocusModifier: ViewModifier {
  @Binding var condition: Bool
  let position: FocusPosition
  let animation: FocusAreaModifier.ArrowAnimation
  @StateObject private var viewModel = FocusModifierViewModel()
  @EnvironmentObject private var areaViewModel: GlobalFocusAreaViewModel
  private var horizontalAlignment: HorizontalAlignment {
    position == .left ? .leading : .trailing
  }
  private var arrowPadding: CGFloat {
    position == .left ? -30 : 30
  }
  
  func body(content: Content) -> some View {
    content
      .ifModifier(condition: condition) { view in
        view
          .alignmentGuide(Alignment.focusHorizontalAlignment) { $0[horizontalAlignment] + arrowPadding }
          .alignmentGuide(Alignment.focusVerticalAlignment) { $0[VerticalAlignment.center] }
      }
      .onChange(of: condition) { value in
        areaViewModel.didChangeValue(value, forFocusWithID: viewModel.id, position: position, animation: animation)
        guard value else { return }
        viewModel.listenForChanges(with: areaViewModel)
      }
      .onReceive(viewModel.$isActive) {
        guard !$0 else { return }
        condition = false
      }
  }
}

private final class FocusModifierViewModel: ObservableObject {
  @Published var isActive: Bool = false
  let id: String = UUID().uuidString
  private var cancellable: AnyCancellable?
  
  func listenForChanges(with areaViewModel: GlobalFocusAreaViewModel) {
    cancellable = areaViewModel.currentFocusPublisher.receive(on: RunLoop.main).sink { [weak self] focusId in
      guard focusId != self?.id else { return }
      self?.isActive = false
    }
  }
}
