//
//  BooksView.swift
//  WWDC21
//
//  Created by Tomas Trujillo on 2021-07-05.
//

import SwiftUI

struct BooksView: View {
  @StateObject private var viewModel = BooksViewModel()
  
  var body: some View {
    content
      .navigationTitle(Text("Books"))
      .task {
        viewModel.fetchBooks()
      }
  }
  
  @ViewBuilder
  private var content: some View {
    if viewModel.books.isEmpty {
      ProgressView()
    } else {
      booksList
    }
  }
  
  private var booksList: some View {
    List {
      ForEach($viewModel.books) { $book in
        BookRow(book: book)
          .swipeActions {
            Button(action: { }) {
              Label("Pin", systemImage: "pin")
            }
            .tint(.orange)
            Button(role: .destructive, action: { withAnimation { viewModel.remove(book) } }) {
              Label("Delete", systemImage: "trash.fill")
            }
          }
          .swipeActions(edge: .leading) {
            Button(action: { book.isRead.toggle() }) {
              Label(book.isRead ? "Mark Unread" : "Mark Read",
                    systemImage: book.isRead ? "book" : "text.book.closed")
            }
            .tint(.purple)
          }
      }
      .listRowSeparator(.hidden)
    }
    .refreshable {
      viewModel.refresh()
    }
  }
}

private struct BookRow: View {
  let book: Book
  
  var body: some View {
    HStack(spacing: 16) {
      Image(systemName: book.iconName)
        .padding()
        .background(book.color, in: RoundedRectangle(cornerRadius: 8.0))
      Text(book.name)
      Spacer()
      if book.isRead {
        Image(systemName: "text.book.closed")
          .foregroundColor(.purple)
      }
    }
  }
}

struct BooksView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      BooksView()
    }
  }
}
