//
//  CWTScrollView.swift
//  WWDC21
//
//  Created by Tomas Trujillo on 2022-06-07.
//

import SwiftUI

struct CWTScrollView<Content: View>: View {
  @Environment(\.refresh) private var refresh
  @StateObject private var viewModel = CWTScrollViewModel()
  
  let content: () -> Content
  var body: some View {
    ScrollView {
      ZStack(alignment: .top) {
        content()
        GeometryReader { proxy in
          Rectangle().fill(Color.clear)
            .frame(width: 10, height: 10)
            .preference(key: ScrollOffsetPreference.self, value: proxy.frame(in: .global).origin.y)
        }
      }
    }
    .onPreferenceChange(ScrollOffsetPreference.self) { value in
      viewModel.didUpdateOffset(value)
    }
    .onChange(of: viewModel.isRefreshing) { isRefreshing in
      guard isRefreshing else { return }
      Task { await refresh?() }
    }
  }
}

private final class CWTScrollViewModel: ObservableObject {
  private var offset: CGFloat?
  private var initialOffset: CGFloat = 0.0
  private let distanceToTriggerRefresh: CGFloat = 100
  @Published var isRefreshing: Bool = false
  
  @MainActor
  func didUpdateOffset(_ value: CGFloat) {
    if let _ = offset {
      self.offset = value
      let difference = value - initialOffset
      if difference > distanceToTriggerRefresh, !isRefreshing {
        isRefreshing = true
      } else if difference < distanceToTriggerRefresh {
        isRefreshing = false
      }
    } else {
      // Starting to scroll
      self.offset = value
      self.initialOffset = value
    }
  }
}

private struct ScrollOffsetPreference: PreferenceKey {
  static var defaultValue: CGFloat = 0.0
  
  static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
    value = nextValue()
  }
}
