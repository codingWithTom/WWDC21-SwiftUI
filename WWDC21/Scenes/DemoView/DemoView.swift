//
//  DemoView.swift
//  WWDC21
//
//  Created by Tomas Trujillo on 2021-11-02.
//

import SwiftUI

struct DemoView: View {
  @State private var isShowingTopLeft: Bool = false
  @State private var isShowingTopRight: Bool = false
  @State private var isShowingBottomLeft: Bool = false
  @State private var isShowingBottomRight: Bool = false
  
  var body: some View {
    VStack {
      HStack {
        Button(action: { isShowingTopLeft.toggle() }) {
          Text("Top Left")
        }
        .modifier(FocusModifier(
          condition: $isShowingTopLeft,
          position: .right
        ))
        
        Spacer()
        
        Button(action: { isShowingTopRight.toggle() }) {
          Text("Top Right")
        }
        .modifier(FocusModifier(
          condition: $isShowingTopRight,
          position: .left
        ))
      }
      
      Spacer()
      
      HStack {
        Button(action: { isShowingBottomLeft.toggle() }) {
          Text("Bottom Left")
        }
        .modifier(FocusModifier(
          condition: $isShowingBottomLeft,
          position: .right
        ))
        
        Spacer()
        
        Button(action: { isShowingBottomRight.toggle() }) {
          Text("Bottom Right")
        }
        .modifier(FocusModifier(
          condition: $isShowingBottomRight, position: .left
        ))
      }
    }
    .padding()
    .modifier(FocusAreaModifier())
  }
}

struct DemoView_Previews: PreviewProvider {
  static var previews: some View {
    DemoView()
  }
}
