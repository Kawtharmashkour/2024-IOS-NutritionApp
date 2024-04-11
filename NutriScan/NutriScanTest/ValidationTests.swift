//
//  ValidationTests.swift
//  NutriScanTest
//
//  Created by behnaz Khalili on 2024-04-09.
//

import XCTest
@testable import NutriScan

final class ValidationTests: XCTestCase {

    func testValidateEmail() {
            XCTAssertEqual(Validation.validateEmail(""), "Email can not be empty")
            XCTAssertEqual(Validation.validateEmail("invalidemail"), "Invalid email format")
            XCTAssertEqual(Validation.validateEmail("valid.email@example.com"), "")
        }

        func testIsValidEmail() {
            XCTAssertFalse(Validation.isValidEmail("invalidemail"))
            XCTAssertTrue(Validation.isValidEmail("valid.email@example.com"))
            
        }

        func testValidateFullName() {
            XCTAssertEqual(Validation.validateFullName(""), "Full name can not be empty")
            XCTAssertEqual(Validation.validateFullName("123"), "Invalid name format")
            XCTAssertEqual(Validation.validateFullName("John Doe"), "")
        }

        func testIsValidFullName() {
            XCTAssertFalse(Validation.isValidFullName("123"))
            XCTAssertTrue(Validation.isValidFullName("John Doe"))
        }

        func testValidatePassword() {
            XCTAssertEqual(Validation.validatePassword(""), "Password can not be empty")
            XCTAssertEqual(Validation.validatePassword("short"), "Invalid password format")
            XCTAssertEqual(Validation.validatePassword("validPass123!"), "")
        }

        func testIsValidPassword() {
            XCTAssertFalse(Validation.isValidPassword("short"))
            XCTAssertTrue(Validation.isValidPassword("validPass123!"))
        }

        func testValidateConfirmedPassword() {
            XCTAssertEqual(Validation.validateConfirmedPassword("password", ""), "Confirmed password can not be empty")
            XCTAssertEqual(Validation.validateConfirmedPassword("password", "different"), "Passwords do not match")
            XCTAssertEqual(Validation.validateConfirmedPassword("password", "password"), "")
        }

        func testIsValidConfirmedPassword() {
            XCTAssertFalse(Validation.isValidConfirmedPassword("password", "different"))
            XCTAssertTrue(Validation.isValidConfirmedPassword("password", "password"))
        }

        // Similar tests for validateWeight, isValidWeight, validateHeight, isValidHeight, etc.

        func testValidateEditPassword() {
            XCTAssertEqual(Validation.validateEditPassword(""), "")
            XCTAssertEqual(Validation.validateEditPassword("short"), "Invalid password format")
            XCTAssertEqual(Validation.validateEditPassword("validPass123!"), "")
        }

        func testValidateEditConfirmedPassword() {
            XCTAssertEqual(Validation.validateEditConfirmedPassword("password", "different"), "Passwords do not match")
            XCTAssertEqual(Validation.validateEditConfirmedPassword("password", "password"), "")
        }

        func testValidateAge() {
            XCTAssertEqual(Validation.validateAge(""), "Age can not be empty")
            XCTAssertEqual(Validation.validateAge("abc"), "Inavalid age format")
            XCTAssertEqual(Validation.validateAge("25"), "")
        }

        func testIsValidAge() {
            XCTAssertFalse(Validation.isValidAge("abc"))
            XCTAssertTrue(Validation.isValidAge("25"))
        }

}
