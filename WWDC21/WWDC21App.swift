//
//  WWDC21App.swift
//  WWDC21
//
//  Created by Tomas Trujillo on 2021-06-10.
//

import SwiftUI

@main
struct WWDC21App: App {
  @State private var isLoginSuccessful: Bool = false
  
  var body: some Scene {
    WindowGroup {
      if isLoginSuccessful {
         WWDCTab()
          .transition(.slide)
      } else {
        LoginView(isLoginSuccessful: $isLoginSuccessful)
          .transition(.slide)
      }
    }
  }
}
