//
//  LoginView.swift
//  WWDC21
//
//  Created by Tomas Trujillo on 2021-06-10.
//

import SwiftUI

struct LoginView: View {
  var colors = [Color.orange, .cyan, .brown, .pink, .yellow, .blue, .red, .green]
  @StateObject private var viewModel = LoginViewModel()
  @Binding var isLoginSuccessful: Bool
  
  var body: some View {
    NavigationView {
      ZStack {
        VStack {
          title
          canvas
          Spacer()
          continueButton
          if let message = viewModel.errorMessage {
            Text(message)
              .foregroundColor(.red)
          }
          Spacer()
          terms
        }
      }
      .navigationBarHidden(true)
    }
    .onReceive(viewModel.$moveToNextView) { moveToNextView in
      withAnimation {
        isLoginSuccessful = moveToNextView
      }
    }
  }
  
  @ViewBuilder
  private var continueButton: some View {
    if viewModel.isLoading {
      ProgressView()
    } else {
      Button(action: { viewModel.didTapContinue() }) {
        Text("Continue")
          .font(.largeTitle)
      }
    }
  }
  
  private var title: some View {
    HStack {
      Text("Codign With Tom")
        .font(.title)
      Spacer()
    }
    .padding()
    .background(.cyan, in: RoundedRectangle(cornerRadius: 6))
    .padding(.horizontal)
  }
  
  private var terms: some View {
    HStack {
      Spacer()
      Text("By tapping \(Text("continue").bold()) you agree to our \(termsText)")
      Spacer()
    }
    .padding()
    .background(.regularMaterial)
  }
  
  private var canvas: some View {
    TimelineView(.animation) { timeline in
      Canvas { context, size in
        let image = context.resolve(Image(systemName: "applelogo"))
        let imageSize = image.size
        let padding: CGFloat = 10
        let numberOfLogos = 10
        let remainder = timeline.date.timeIntervalSinceReferenceDate.remainder(dividingBy: 3)
        (0 ..< numberOfLogos).forEach {
          let percent = CGFloat($0) / CGFloat(numberOfLogos)
          let offset = remainder * size.width
          let xCoordinate = (size.width - padding) * percent + imageSize.width
                              + padding + (offset * CGFloat(1 - 2 * ($0 % 2)))
          let point = CGPoint(x: xCoordinate,
                              y: (size.height - padding) * percent + imageSize.height / 2 + padding)
          let scale: CGFloat = 1.5
          let fillRect = CGRect(
            origin: CGPoint(
              x: point.x - imageSize.width * scale / 2,
              y: point.y - imageSize.height * scale / 2),
            size: CGSize(width: imageSize.width * scale, height: imageSize.height * scale))
          context.fill(Circle().path(in: fillRect), with: .color(colors[$0 % colors.count]))
          context.draw(image, at: point)
        }
        context.draw(
          Text("\(remainder > -0.5 ? wwdcText : emptyText) \(remainder > 0.5 ? yearText : emptyText) \(remainder > 1 ? iconText : emptyText)"),
          at: CGPoint(x: size.width / 2, y: size.height / 2))
      }
      .frame(height: 250)
    }
  }
  
  private var termsText: Text {
    Text("Terms and Conditions")
      .bold()
      .foregroundColor(.blue)
  }
  
  private var emptyText: Text {
    Text("")
  }
  
  private var wwdcText: Text {
    Text("WWDC")
      .bold()
      .font(.largeTitle)
  }
  
  private var yearText: Text {
    Text("2021")
      .italic()
      .font(.largeTitle)
  }
  
  private var iconText: Text {
    Text("📱")
      .font(.largeTitle)
  }
}

struct LoginView_Previews: PreviewProvider {
  static var previews: some View {
    LoginView(isLoginSuccessful: .constant(false))
  }
}
