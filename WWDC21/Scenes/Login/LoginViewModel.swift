//
//  LoginViewModel.swift
//  WWDC21
//
//  Created by Tomas Trujillo on 2021-06-21.
//

import Foundation

final class LoginViewModel: ObservableObject {
  @Published var isLoading: Bool = false
  @Published var moveToNextView: Bool = false
  @Published var errorMessage: String?
  
  var loginService: LoginService = LoginServiceAdapter.shared
  
  func didTapContinue() {
    isLoading = true
    errorMessage = nil
    async {
      do {
        let success = try await loginService.login()
        await MainActor.run {
          isLoading = false
          moveToNextView = success
        }
      } catch {
        await receivedErrorForLogin(error)
      }
    }
  }
  
  @MainActor
  private func receivedErrorForLogin(_ error: Error) {
    isLoading = false
    switch error {
    case LoginError.wrongPassword:
      errorMessage = "Wrong credentials"
    case LoginError.networkError:
      errorMessage = "Couldn't connect to network"
    default:
      errorMessage = "Something went wrong. Please try again."
    }
  }
}
