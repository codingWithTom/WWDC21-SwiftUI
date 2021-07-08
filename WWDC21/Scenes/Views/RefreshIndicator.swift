//
//  RefreshIndicator.swift
//  WWDC21
//
//  Created by Tomas Trujillo on 2021-07-05.
//

import SwiftUI

struct RefreshIndicator: View {
  var body: some View {
    TimelineView(.animation) { timeline in
      Canvas { context, size in
        let offset = timeline.date.timeIntervalSinceReferenceDate.remainder(dividingBy: 3) * size.width
        let gradient = Gradient(colors: [.blue, .blue.opacity(0.3), .blue.opacity(0.8)])
        let startPoint = CGPoint(x: offset, y: 0.0)
        let endPoint = CGPoint(x: size.width / 3 + offset, y: 0.0)
        context.fill(Path(CGRect(origin: .zero,
                                 size: CGSize(width: size.width, height: 5))),
                     with: .linearGradient(gradient, startPoint: startPoint, endPoint: endPoint))
      }
    }
  }
}

struct RefreshIndicator_Previews: PreviewProvider {
  static var previews: some View {
    RefreshIndicator()
  }
}
