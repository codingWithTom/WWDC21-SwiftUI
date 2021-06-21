//
//  NetworkService.swift
//  WWDC21
//
//  Created by Tomas Trujillo on 2021-06-17.
//

import Foundation
import UIKit

enum LoginError: Error {
  case wrongPassword
  case networkError
}

enum ImageError: Error {
  case imageNotFound
}

final class NetworkService {
  static let shared = NetworkService()
  
  private init() {}
  
  func fetchRequest() throws -> Bool {
    Thread.sleep(until: Date().addingTimeInterval(2))
//    throw LoginError.wrongPassword
    return true
  }
  
  func downloadImage(withURL url: URL) throws -> UIImage {
    Thread.sleep(until: Date().addingTimeInterval(3))
    
    if let image = UIImage(contentsOfFile: url.path) {
      return image
    } else {
      throw ImageError.imageNotFound
    }
  }
}
