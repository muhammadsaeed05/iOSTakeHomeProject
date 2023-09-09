//
//  NetworkingEndpointTests.swift
//  iOSTakeHomeProjectTests
//
//  Created by Muhammad Saeed on 03/09/2023.
//

import XCTest
@testable import iOSTakeHomeProject

final class NetworkingEndpointTests: XCTestCase {

    func test_Endpoint_people_isValid() {
        let endpont = Endpoints.people(page: 1)
        
        XCTAssertEqual(endpont.host, "reqres.in", "The host should be reqres.in")
        XCTAssertEqual(endpont.path, "/api/users", "The path should be /api/users")
        XCTAssertEqual(endpont.methodType, .GET, "The method type should be GET")
        XCTAssertEqual(endpont.queryItems , ["page": "1"], "The query items should be page:1")
        XCTAssertEqual(endpont.url?.absoluteString, "https://reqres.in/api/users?page=1&delay=1", "The generated url doesnot match our endpoint")
    }
    
    func test_Endpoint_detail_isValid() {
        let userId = 1
        let endpont = Endpoints.detail(id: userId)
        
        XCTAssertEqual(endpont.host, "reqres.in", "The host should be reqres.in")
        XCTAssertEqual(endpont.path, "/api/users/\(userId)", "The path should be /api/users/\(userId)")
        XCTAssertEqual(endpont.methodType, .GET, "The method type should be GET")
        XCTAssertNil(endpont.queryItems , "The query items should be nil")
        XCTAssertEqual(endpont.url?.absoluteString, "https://reqres.in/api/users/\(userId)?delay=1", "The generated url doesnot match our endpoint")
    }
    
    func test_Endpoint_create_isValid() {
        let endpont = Endpoints.create(data: nil)
        
        XCTAssertEqual(endpont.host, "reqres.in", "The host should be reqres.in")
        XCTAssertEqual(endpont.path, "/api/users", "The path should be /api/users")
        XCTAssertEqual(endpont.methodType, .POST(data: nil), "The method type should be POST")
        XCTAssertNil(endpont.queryItems , "The query items should be nil")
        XCTAssertEqual(endpont.url?.absoluteString, "https://reqres.in/api/users?delay=1", "The generated url doesnot match our endpoint")
    }
}
