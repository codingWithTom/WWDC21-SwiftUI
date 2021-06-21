//
//  ImageService.swift
//  WWDC21
//
//  Created by Tomas Trujillo on 2021-06-18.
//

import UIKit

protocol ImageService {
  func getImages(completion: @escaping ([UIImage], Error?) -> Void)
}

final class ImageServiceAdapter: ImageService {
  static let shared = ImageServiceAdapter()
  
  private let queue = DispatchQueue(label: "Image queue", qos: .userInitiated)
  
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
        completion(images, nil)
      }
    }
  }
}
