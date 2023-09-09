//
//  NetworkingManagerTests.swift
//  iOSTakeHomeProjectTests
//
//  Created by Muhammad Saeed on 04/09/2023.
//

import XCTest
@testable import iOSTakeHomeProject

final class NetworkingManagerTests: XCTestCase {
    
    private var session: URLSession!
    private var url: URL!

    override func setUp() {
        url = URL(string: "https://reqres.in/api/users")
        
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLSessionProtocol.self]
        session = URLSession(configuration: configuration)
    }

    override func tearDownWithError() throws {
        session = nil
        url = nil
    }

    func test_NetworkingManager_request_withSuccessfulResponseResponseShouldBeValid() async throws {
        guard let path = Bundle.main.path(forResource: "UsersStaticData", ofType: "json"),
              let data = FileManager.default.contents(atPath: path)
        else {
            XCTFail("Failed to get the static file data")
            return
        }
        
        MockURLSessionProtocol.loadingHandler = {
            let response = HTTPURLResponse(url: self.url, statusCode: 200, httpVersion: nil, headerFields: nil)
            
            return (response!, data)
        }
        
        let res = try await NetworkingManager.shared.request(session: session, .people(page: 1), type: UsersResponse.self)
        
        let staticJSON = try StaticJSONMapper.decode(file: "UsersStaticData", type: UsersResponse.self)
        
        XCTAssertEqual(staticJSON, res, "The returned response should be decoded successfully")
    }

}
