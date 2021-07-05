//
//  HomeView.swift
//  WWDC21
//
//  Created by Tomas Trujillo on 2021-06-21.
//

import SwiftUI

struct HomeView: View {
  
  @StateObject private var viewModel = HomeViewModel()
  
  var body: some View {
    VStack {
      Text("Welcome Developer!")
        .font(.title)
      Spacer()
      if viewModel.isLoading {
        ProgressView()
      } else {
        content
      }
      Spacer()
      button
    }
    .navigationTitle(Text("Home"))
  }
  
  private var content: some View {
    ScrollView {
      LazyVGrid(columns: [.init(.flexible()), .init(.flexible())]) {
        ForEach(viewModel.images.indices, id: \.self) { index in
          Image(uiImage: viewModel.images[index])
            .resizable()
            .scaledToFit()
        }
      }
    }
  }
  
  @ViewBuilder
  private var button: some View {
    if viewModel.isLoading {
      Button(action: { viewModel.didTapCancel() }) {
        Text("Cancel")
          .foregroundColor(.red)
          .font(.title2)
          .padding()
          .background(.white, in: Capsule())
          .shadow(radius: 2)
      }
    }
    else {
      Button(action: { viewModel.didTapDownload() }) {
        Text("Download")
          .font(.title2)
          .foregroundColor(.black)
          .padding()
          .background(.yellow, in: Capsule())
      }
    }
  }
}

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    HomeView()
  }
}
