//
//  LoginService.swift
//  WWDC21
//
//  Created by Tomas Trujillo on 2021-06-17.
//

import Foundation

protocol LoginService {
  func login(completion: @escaping (Bool, Error?) -> Void)
}

final class LoginServiceAdapter: LoginService {
  static let shared = LoginServiceAdapter()
  
  private let queue = DispatchQueue(label: "Login queue", qos: .userInitiated)
  
  private init () {}
  
  func login(completion: @escaping (Bool, Error?) -> Void) {
    queue.async {
      do {
        let outcome = try NetworkService.shared.fetchRequest()
        completion(outcome, nil)
      } catch {
        completion(false, error)
      }
    }
  }
}
