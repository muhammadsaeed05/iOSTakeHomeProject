//
//  JSONMapperTests.swift
//  iOSTakeHomeProjectTests
//
//  Created by Muhammad Saeed on 03/09/2023.
//

import XCTest
@testable import iOSTakeHomeProject

final class JSONMapperTests: XCTestCase {

    func test_JSONMapper_decode_withValidJSONShouldSucccessfullydDecode() {
                
        XCTAssertNoThrow(try StaticJSONMapper.decode(file: "UsersStaticData", type: UsersResponse.self), "Mapper shouldn't throw an error")
        
        let userResponse = try? StaticJSONMapper.decode(file: "UsersStaticData", type: UsersResponse.self)
        XCTAssertNotNil(userResponse, "User response shouldn't be nil")
        
        XCTAssertEqual(userResponse?.page, 1, "Page number should be 1")
        XCTAssertEqual(userResponse?.perPage, 6, "Per Page number should be 6")
        XCTAssertEqual(userResponse?.total, 12, "Total number should be 12")
        XCTAssertEqual(userResponse?.totalPages, 2, "Total Pages number should be 2")
        
        XCTAssertEqual(userResponse?.data.count, 6, "The total number of users should be 6")
        
        XCTAssertEqual(userResponse?.data[0].id, 1, "The id should be 1")
        XCTAssertEqual(userResponse?.data[0].firstName, "George", "The first name should be George")
        XCTAssertEqual(userResponse?.data[0].lastName, "Bluth", "The last name should be Bluth")
    }
    
    func test_JSONMapper_decode_withMissingFileShouldThrowError() {
        XCTAssertThrowsError(try StaticJSONMapper.decode(file: "", type: UsersResponse.self), "Mapper should throw an error")
        
        do {
            let _ = try StaticJSONMapper.decode(file: "", type: UsersResponse.self)
        } catch {
            guard let mappingError = error as? StaticJSONMapper.MappingError else {
                XCTFail("This is the wrong type of error for missing files")
                return
            }
            
            XCTAssertEqual(mappingError, StaticJSONMapper.MappingError.failedToGetContents, "This should be a failed to get content errors")
        }
    }
    
    func test_JSONMapper_decode_withInvalidFileShouldThrowError() {
        XCTAssertThrowsError(try StaticJSONMapper.decode(file: "notafile", type: UsersResponse.self), "Mapper should throw an error")
        
        do {
            let _ = try StaticJSONMapper.decode(file: "notafile", type: UsersResponse.self)
        } catch {
            guard let mappingError = error as? StaticJSONMapper.MappingError else {
                XCTFail("This is the wrong type of error for missing files")
                return
            }
            
            XCTAssertEqual(mappingError, StaticJSONMapper.MappingError.failedToGetContents, "This should be a failed to get content errors")
        }
    }
    
    func test_JSONMapper_decode_withInvalidJSONShouldThrowError() {
        XCTAssertThrowsError(try StaticJSONMapper.decode(file: "UsersStaticData", type: UserDetailResponse.self), "An error should be an error")
        
        do {
            let _ = try StaticJSONMapper.decode(file: "UsersStaticData", type: UserDetailResponse.self)
        } catch {
            if error is StaticJSONMapper.MappingError {
                XCTFail("Got the wrong type of error")
            }
        }
        
    }

}
