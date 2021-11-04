//
//  FocusAlignment.swift
//  WWDC21
//
//  Created by Tomas Trujillo on 2021-11-02.
//

import SwiftUI

extension Alignment {
  private struct FocusHAlignment: AlignmentID {
    static func defaultValue(in context: ViewDimensions) -> CGFloat {
      return context[HorizontalAlignment.center]
    }
  }
  
  private struct FocusVAlignment: AlignmentID {
    static func defaultValue(in context: ViewDimensions) -> CGFloat {
      return context[VerticalAlignment.center]
    }
  }
  
  static var focusHorizontalAlignment: HorizontalAlignment {
    return HorizontalAlignment(FocusHAlignment.self)
  }
  
  static var focusVerticalAlignment: VerticalAlignment {
    return VerticalAlignment(FocusVAlignment.self)
  }
  
  static var focusAlignment: Alignment {
    return Alignment(horizontal: focusHorizontalAlignment, vertical: focusVerticalAlignment)
  }
}
