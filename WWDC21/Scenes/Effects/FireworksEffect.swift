//
//  FireworksEffect.swift
//  WWDC21
//
//  Created by Tomas Trujillo on 2021-12-02.
//

import SwiftUI

struct FireworksEffect: ViewModifier {
  
  let numberOfFireworks: Int
  
  func body(content: Content) -> some View {
    content
      .overlay(
        FireWorksView(numberOfFireworks: numberOfFireworks)
      )
  }
}

struct FireworksEffect_Previews: PreviewProvider {
  static var previews: some View {
    Rectangle()
      .fill()
      .frame(width: 200, height: 200)
      .modifier(FireworksEffect(numberOfFireworks: 10))
  }
}

private struct FireWorksView: View {
  let numberOfFireworks: Int
  @State private var xPosition: [CGFloat]
  @State private var yPosition: [CGFloat]
  @State private var colors: [Color]
  @State private var animated: [Bool]
  
  init(numberOfFireworks: Int) {
    let randomColors: [Color] = [
      .blue, .cyan, .red, .yellow, .purple, .pink, .green
    ]
    self.numberOfFireworks = numberOfFireworks
    xPosition = (0 ..< numberOfFireworks)
      .map { _ in CGFloat.random(in: 0 ... 0.5) * (Bool.random() ? -1 : 1) }
    yPosition = (0 ..< numberOfFireworks)
      .map { _ in CGFloat.random(in: 0 ... 0.5) }
    colors = (0 ..< numberOfFireworks)
      .map { _ in randomColors.randomElement() ?? .blue }
    animated = (0 ..< numberOfFireworks)
      .map { _ in false }
  }
  
  var body: some View {
    GeometryReader { geometry in
      let width = geometry.size.width
      let height = geometry.size.height
      let size = width * 0.05
      ZStack {
        Rectangle().fill(Color.clear)
        Group {
          ForEach(0 ..< numberOfFireworks, id: \.self) { index in
            Firework(isAnimating: animated[index], totalDistance: size * 2)
              .fill(colors[index])
              .frame(width: size, height: size)
              .offset(
                x: width * xPosition[index],
                y: height * yPosition[index]
              )
              .animation(.linear(duration: 0.5)
                          .delay(0.5)
                          .repeatForever(autoreverses: false),
                         value: animated[index])
              .modifier(
                FireworkTranslationEffect(isOn: animated[index], height: -height / 2)
              )
              .animation(.linear(duration: 1.0)
                          .repeatForever(autoreverses: false),
                         value: animated[index])
              .opacity(animated[index] ? 1.0 : 0.0)
          }
        }
      }
    }
    .onAppear {
      for index in 0 ..< numberOfFireworks {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2 + 0.2 * Double(index)) {
          self.animated[index] = true
        }
      }
    }
  }
}

private struct FireworkTranslationEffect: GeometryEffect {
  private var percent: CGFloat
  var animatableData: CGFloat {
    get { percent }
    set { percent = newValue }
  }
  
  private let height: CGFloat
  
  init(isOn: Bool, height: CGFloat) {
    self.percent = isOn ? 1.0 : 0.0
    self.height = height
  }
  
  func effectValue(size: CGSize) -> ProjectionTransform {
    guard percent != 0, percent != 1 else { return ProjectionTransform(.identity) }
    let transform: CGAffineTransform
    if percent < 0.5 {
      let relativePercent = percent / 0.5
      transform = .init(translationX: 0.0, y: height * relativePercent)
    } else {
      transform = .init(translationX: 0.0, y: height)
    }
    
    return ProjectionTransform(transform)
  }
}

struct Firework: Shape {
  private var offset: CGFloat
  var animatableData: CGFloat {
    get { offset }
    set { offset = newValue }
  }
  
  let totalDistance: CGFloat
  
  init(isAnimating: Bool, totalDistance: CGFloat) {
    self.totalDistance = totalDistance
    self.offset = isAnimating ? totalDistance : 0.0
  }
  
  func path(in rect: CGRect) -> Path {
    var path = Path()
    if offset == 0.0 || offset == totalDistance {
      path.addEllipse(in: rect.applying(.init(scaleX: 0.5, y: 0.5)))
    } else {
      path.addEllipse(in: rect.offsetBy(dx: offset, dy: 0.0))
      path.addEllipse(in: rect.offsetBy(dx: offset / 2, dy: offset / 2))
      path.addEllipse(in: rect.offsetBy(dx: 0.0, dy: offset))
      path.addEllipse(in: rect.offsetBy(dx: -offset / 2, dy: offset / 2))
      path.addEllipse(in: rect.offsetBy(dx: -offset, dy: 0.0))
      path.addEllipse(in: rect.offsetBy(dx: -offset / 2, dy: -offset / 2))
      path.addEllipse(in: rect.offsetBy(dx: 0.0, dy: -offset))
      path.addEllipse(in: rect.offsetBy(dx: offset / 2, dy: -offset / 2))
    }
    return path
  }
}
