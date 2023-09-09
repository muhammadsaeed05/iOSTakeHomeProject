//
//  CreateViewModel.swift
//  iOSTakeHomeProject
//
//  Created by Muhammad Saeed on 31/08/2023.
//

import Foundation

final class CreateViewModel: ObservableObject {
    
    @Published var person = NewPerson()
    @Published private(set) var state: SubmissionState?
    @Published private(set) var error: FormError?
    @Published var hasError: Bool = false
    
    private let validator = CreateValidator()
    
    @MainActor
    func create() async {
        
        do {
            
            try validator.validate(person)
            
            state = .submitting
            
            let encoder = JSONEncoder()
            encoder.keyEncodingStrategy = .convertToSnakeCase
            let data = try? encoder.encode(person)
            
            try await NetworkingManager.shared.request(.create(data: data))
            
            state = .successful
            
        } catch {
            self.hasError = true
            self.state = .unsuccessful

            switch error {
            case is NetworkingManager.NetworkingError:
                self.error = .networking(error: error as! NetworkingManager.NetworkingError)
            case is CreateValidator.CreateValidatorError:
                self.error = .validation(error: error as! CreateValidator.CreateValidatorError)
            default:
                self.error = .system(error: error)
            }
        }
        
        
    }
    
}

//MARK: SubmissionState

extension CreateViewModel {
    enum SubmissionState {
        case successful
        case unsuccessful
        case submitting
    }
}

//MARK: FormError

extension CreateViewModel {
    enum FormError: LocalizedError {
        case networking(error: LocalizedError)
        case validation(error: LocalizedError)
        case system(error: Error)

    }
}

//MARK: FormError errorDescription

extension CreateViewModel.FormError {
    var errorDescription: String? {
        switch self {
        case .networking(let error),
                .validation(let error):
            return error.errorDescription
        case .system(let error):
            return error.localizedDescription
        }
    }
}
