//
//  Book.swift
//  WWDC21
//
//  Created by Tomas Trujillo on 2021-07-05.
//

import Foundation
import SwiftUI

struct Book: Identifiable {
  let id: UUID
  let name: String
  let iconName: String
  let color: Color
  var isRead: Bool = false
}
