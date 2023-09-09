//
//  CreateFormValidatorTests.swift
//  iOSTakeHomeProjectTests
//
//  Created by Muhammad Saeed on 03/09/2023.
//

import XCTest
@testable import iOSTakeHomeProject

final class CreateFormValidatorTests: XCTestCase {
    
    private var validator: CreateValidator?
    
    override func setUp() {
        validator = CreateValidator()
    }
    
    override func tearDown() {
        validator = nil
    }

    func test_CreateValidator_validate_withEmptyPersonFirstNameShouldThrowError() throws {
        let person = NewPerson()
        
        do {
            _ = try validator?.validate(person)
        } catch {
            guard let validationError = error as? CreateValidator.CreateValidatorError else {
                XCTFail("Got the wrong type of error expecting a create validator error")
                return
            }
            
            XCTAssertEqual(validationError, .invalidFirstName, "Expecting an error where we have an invalid first name")
        }
        
    }
    
    func test_CreateValidator_validate_withEmptyFirstNameShouldThrowError() throws {
        let person = NewPerson(lastName: "Last", job: "Job")
        
        do {
            _ = try validator?.validate(person)
        } catch {
            guard let validationError = error as? CreateValidator.CreateValidatorError else {
                XCTFail("Got the wrong type of error expecting a create validator error")
                return
            }
            
            XCTAssertEqual(validationError, .invalidFirstName, "Expecting an error where we have an invalid first name")
        }
    }
    
    func test_CreateValidator_validate_withEmptyLastNameShouldThrowError() throws {
        let person = NewPerson(firstName: "First", job: "Job")
        
        do {
            _ = try validator?.validate(person)
        } catch {
            guard let validationError = error as? CreateValidator.CreateValidatorError else {
                XCTFail("Got the wrong type of error expecting a create validator error")
                return
            }
            
            XCTAssertEqual(validationError, .invalidLastName, "Expecting an error where we have an invalid last name")
        }
    }
    
    func test_CreateValidator_validate_withEmptyJobNameShouldThrowError() throws {
        let person = NewPerson(firstName: "First", lastName: "Last")
        
        do {
            _ = try validator?.validate(person)
        } catch {
            guard let validationError = error as? CreateValidator.CreateValidatorError else {
                XCTFail("Got the wrong type of error expecting a create validator error")
                return
            }
            
            XCTAssertEqual(validationError, .invalidJob, "Expecting an error where we have an invalid job")
        }
    }
    
    func test_CreateValidator_validate_withValidPersonShouldnotThrowError() throws {
        let person = NewPerson(firstName: "First",lastName: "Last", job: "Job")
        let validator = CreateValidator()
        
        do {
            try validator.validate(person)
        } catch {
            XCTFail("No error should be thrown")
        }
    }

}
