//
//  ImageService.swift
//  WWDC21
//
//  Created by Tomas Trujillo on 2021-06-18.
//

import UIKit

protocol ImageService {
  func getImages(completion: @escaping ([UIImage], Error?) -> Void)
  func getImages() async throws -> [UIImage]
  func cancelDownload()
}

final class ImageServiceAdapter: ImageService {
  static let shared = ImageServiceAdapter()
  
  private let queue = DispatchQueue(label: "Image queue", qos: .userInitiated)
  private var downloadTask: Task.Handle<[UIImage], Error>?
  
  private init() {}
  
  func getImages(completion: @escaping ([UIImage], Error?) -> Void) {
    queue.async {
      var images: [UIImage] = []
      for index in (1 ... 10) {
        guard let url = Bundle.main.url(forResource: "image\(index)", withExtension: ".png") else { continue }
        do {
          let image = try NetworkService.shared.downloadImage(withURL: url)
          images.append(image)
        } catch {
          completion(images, error)
        }
      }
      completion(images, nil)
    }
  }
  
  func getImages() async throws -> [UIImage] {
    let task: Task.Handle<[UIImage], Error> = async { [weak self] in
      guard let self = self else { return [] }
      var images: [UIImage] = []
      for index in (1 ... 10) {
        guard !Task.isCancelled else { return images }
        guard let url = Bundle.main.url(forResource: "image\(index)", withExtension: ".png") else { continue }
        let image = try NetworkService.shared.downloadImage(withURL: url)
        images.append(image)
      }
      self.downloadTask = nil
      return images
    }
    self.downloadTask = task
    return try await task.get()
  }
  
  func cancelDownload() {
    downloadTask?.cancel()
    downloadTask = nil
  }
}
