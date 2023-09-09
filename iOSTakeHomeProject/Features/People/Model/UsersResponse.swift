//
//  UsersResponse.swift
//  iOSTakeHomeProject
//
//  Created by Muhammad Saeed on 30/08/2023.
//

import Foundation

// MARK: - UsersResponse
struct UsersResponse: Codable, Equatable {
    let page, perPage, total, totalPages: Int
    let data: [User]
    let support: Support
}
