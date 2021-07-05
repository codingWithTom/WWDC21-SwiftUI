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
      HomeView()
      .tabItem {
        Label("Home", systemImage: "house.fill")
      }
      BooksView()
        .tabItem {
          Label("Books", systemImage: "books.vertical.fill")
        }
    }
  }
}

struct WWDCTab_Previews: PreviewProvider {
  static var previews: some View {
    WWDCTab()
  }
}
