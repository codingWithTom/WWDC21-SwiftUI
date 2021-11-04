//
//  WWDCTab.swift
//  WWDC21
//
//  Created by Tomas Trujillo on 2021-07-05.
//

import SwiftUI

struct WWDCTab: View {
  var body: some View {
    TabView {
      NavigationView {
        HomeView()
      }
      .tabItem {
        Label("Home", systemImage: "house.fill")
      }
      NavigationView {
        BooksView()
      }
      .tabItem {
        Label("Books", systemImage: "books.vertical.fill")
      }
      NavigationView {
        MotionView()
      }
      .tabItem {
        Label("Motion", systemImage: "circle.hexagonpath.fill")
      }
      NavigationView {
        DemoView()
      }
      .tabItem {
        Label("Demo", systemImage: "dpad")
      }
    }
  }
}

struct WWDCTab_Previews: PreviewProvider {
  static var previews: some View {
    WWDCTab()
  }
}
