//
//  HomeView.swift
//  WWDC21
//
//  Created by Tomas Trujillo on 2021-06-21.
//

import SwiftUI

struct HomeView: View {
  
  @StateObject private var viewModel = HomeViewModel()
  @State private var isAnimating = false
  
  var body: some View {
    VStack {
      Text("Welcome Developer!")
        .font(.title)
        .modifier(TiltingAnimation(isOn: isAnimating))
        .animation(.linear(duration: 0.5).delay(1.0).repeatForever(autoreverses: false), value: isAnimating)
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
    .onAppear {
      DispatchQueue.main.async {
        isAnimating = true
      }
    }
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
  
  @Namespace private var downloadButtonNamespace
  private let downloadButtonID = UUID()
  
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
      .matchedGeometryEffect(
        id: downloadButtonID, in: downloadButtonNamespace,
        properties: .frame, anchor: .center
      )
    }
    else {
      Button(action: { viewModel.didTapDownload() }) {
        HStack {
          Spacer()
          Text("Download")
            .font(.title2)
            .foregroundColor(.black)
          Spacer()
        }
        .padding()
        .background(.yellow, in: Capsule())
      }
      .padding(.horizontal)
      .matchedGeometryEffect(
        id: downloadButtonID, in: downloadButtonNamespace,
        properties: .frame, anchor: .center
      )
    }
  }
}

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    HomeView()
  }
}
