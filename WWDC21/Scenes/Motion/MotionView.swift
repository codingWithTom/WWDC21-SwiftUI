//
//  MotionView.swift
//  MotionView
//
//  Created by Tomas Trujillo on 2021-08-08.
//

import SwiftUI

struct MotionView: View {
  @State private var shapes: [AnyView] = []
  @StateObject private var viewModel = MotionViewModel()
  private var colors: [Color] = [.cyan, .purple, .orange, .green, .yellow, .red, .blue]
  
  var body: some View {
    ZStack {
      Rectangle().fill(Color.clear)
      
      contentShapes
      
      ctas
    }
    .contentShape(Rectangle())
    .onTapGesture(count: 2) {
      addShape()
    }
  }
  
  private var contentShapes: some View {
    Group {
      ForEach(shapes.indices, id: \.self) { index in
        shapes[index]
          .offset(viewModel.isAnimating ? randomOffset() : .zero)
          .offset(viewModel.offset)
      }
    }
    .animation(viewModel.isAnimating ?
                .spring(response: 0.5, dampingFraction: 0.5, blendDuration: 0.5).repeatForever() :
                  .linear(duration: 0.0), value: viewModel.isAnimating)
  }
  
  private var ctas: some View {
    VStack(spacing: 20)  {
      Spacer()
      
      Button(action: { viewModel.tappedAnimate() } ) {
        Text("Animate")
      }
      
      Button(action: { viewModel.tappedToggleMotion() } ) {
        Text("Toggle Motion")
      }
    }
    .padding(.bottom)
  }
  
  private func addShape() {
    shapes.append(AnyView(
      Circle()
        .fill(colors.randomElement() ?? .cyan)
        .frame(width: 60, height: 60)
        .offset(randomOffsetPosition())
    ))
  }
  
  private func randomOffset() -> CGSize {
    let xOfsset = CGFloat.random(in: -40 ... 40)
    let yOfsset = CGFloat.random(in: -200 ... 0)
    return CGSize(width: xOfsset, height: yOfsset)
  }
  
  private func randomOffsetPosition() -> CGSize {
    let xOfsset = CGFloat.random(in: -100 ... 100)
    let yOfsset = CGFloat.random(in: -100 ... 100)
    return CGSize(width: xOfsset, height: yOfsset)
  }
}

struct MotionView_Previews: PreviewProvider {
  static var previews: some View {
    MotionView()
  }
}
