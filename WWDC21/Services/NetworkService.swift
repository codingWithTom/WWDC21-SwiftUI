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
  private lazy var books: [Book] = [
    Book(id: UUID(), name: "The Dark Tower", iconName: "building", color: .blue),
    Book(id: UUID(), name: "Game of Thrones", iconName: "circle.hexagongrid", color: .brown),
    Book(id: UUID(), name: "Harry Potter", iconName: "lasso.and.sparkles", color: .orange),
    Book(id: UUID(), name: "Splinter Cell", iconName: "message.and.waveform", color: .cyan),
    Book(id: UUID(), name: "The Lost Island", iconName: "location.north.circle", color: .teal),
    Book(id: UUID(), name: "Treasure Island", iconName: "globe.asia.australia", color: .yellow),
    Book(id: UUID(), name: "Coding With Tom", iconName: "swift", color: .green)
  ]
  
  private init() {}
  
  func fetchRequest() throws -> Bool {
    Thread.sleep(until: Date().addingTimeInterval(2))
//    throw LoginError.wrongPassword
    return true
  }
  
  func downloadImage(withURL url: URL) throws -> UIImage {
    Thread.sleep(until: Date().addingTimeInterval(0.25))
    
    if let image = UIImage(contentsOfFile: url.path) {
      print("Download image with url: \(url.path)")
      return image
    } else {
      throw ImageError.imageNotFound
    }
  }
  
  func fetchBooks() -> [Book] {
    Thread.sleep(until: Date().addingTimeInterval(1))
    return books
  }
}
