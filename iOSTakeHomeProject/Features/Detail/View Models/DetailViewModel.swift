//
//  DetailViewModel.swift
//  iOSTakeHomeProject
//
//  Created by Muhammad Saeed on 31/08/2023.
//

import Foundation

final class DetailViewModel: ObservableObject {
    
    @Published private(set) var userInfo: UserDetailResponse?
    @Published private(set) var error: NetworkingManager.NetworkingError?
    @Published private(set) var isLoading = false
    @Published var hasError: Bool = false
    
    @MainActor
    func fetchDetails(userId: Int) async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            let response = try await NetworkingManager.shared.request(.detail(id: userId), type: UserDetailResponse.self)
            userInfo = response
        } catch {
            self.hasError = true
            if let networkingError = error as? NetworkingManager.NetworkingError {
                self.error = networkingError
            } else {
                self.error = .custom(error: error)
            }
        }
    }
    
}
