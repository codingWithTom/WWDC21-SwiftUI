//
//  BookService.swift
//  WWDC21
//
//  Created by Tomas Trujillo on 2021-07-05.
//

import Foundation

protocol BookService {
  func getBooks() async -> [Book]
}

final class BookServiceAdapter: BookService {
  static let shared = BookServiceAdapter()
  
  private init() { }
  
  func getBooks() async -> [Book] {
    return NetworkService.shared.fetchBooks()
  }
}
