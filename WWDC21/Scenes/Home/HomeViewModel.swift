//
//  HomeViewModel.swift
//  WWDC21
//
//  Created by Tomas Trujillo on 2021-06-21.
//

import UIKit

final class HomeViewModel: ObservableObject {
  @Published var images: [UIImage] = []
  @Published var isLoading: Bool = false
  
  var imageService: ImageService = ImageServiceAdapter.shared
  
  func didTapDownload() {
    isLoading = true
    Task {
      let images = try? await imageService.getImages()
      await MainActor.run {
        isLoading = false
        self.images = images ?? []
      }
    }
  }
  
  func didTapCancel() {
    imageService.cancelDownload()
  }
}
