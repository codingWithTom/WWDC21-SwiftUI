//
//  ViewExtensions.swift
//  WWDC21
//
//  Created by Tomas Trujillo on 2021-11-02.
//

import SwiftUI

extension View {
  
  @ViewBuilder
  func ifModifier<Content: View>(condition: Bool, builder: (Self) -> Content) -> some View {
    if condition {
      builder(self)
    } else {
      self
    }
  }
}
