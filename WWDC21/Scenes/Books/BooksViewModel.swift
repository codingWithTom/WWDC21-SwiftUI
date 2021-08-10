//
//  BooksViewModel.swift
//  WWDC21
//
//  Created by Tomas Trujillo on 2021-07-05.
//

import Foundation
import SwiftUI

final class BooksViewModel: ObservableObject {
  @Published var books: [Book] = []
  @Published var isRefreshing: Bool = false
  
  var bookService: BookService = BookServiceAdapter.shared
  
  func fetchBooks() {
    Task {
      let books = await bookService.getBooks()
      await MainActor.run {
        withAnimation {
          self.isRefreshing = false
          self.books = books
        }
      }
    }
  }
  
  func refresh() {
    self.isRefreshing = true
    fetchBooks()
  }
  
  func remove(_ book: Book) {
    guard let index = books.firstIndex(where: { $0.id == book.id }) else { return }
    books.remove(at: index)
  }
}
