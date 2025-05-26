//
//  SungCalculatorTests.swift
//  SungCalculatorTests
//
//  Created by Tomas Sanni on 5/26/25.
//

import XCTest
@testable import SungCalculator

final class SungCalculatorTests: XCTestCase {
    // Naming Structure: test_UnitOfWork_StateUnderTest_ExpectedBehavior
    // Naming Structure: test_[struct or class]_[variable or function]_[expected result]

    // Testing Structure: Given, When, Then
    var viewModel: CalculatorViewModel?


    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        viewModel = CalculatorViewModel.shared
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewModel = nil
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func test_CalculatorViewModel_toggleHistoryView_shouldBeToggled() {
        // Given
        guard let vm = viewModel else {
            XCTFail("Viewmodel is nil")
            return
        }
        
        // When
        vm.toggleHistoryView()
        
        // Then
        XCTAssertTrue(vm.showHistoryView)
    }
    
    func test_CalculatorViewModel_handleDeleteButtonPressed_showRemoveLastOfTextInputAndArrayOfButtonTypes() {
        // Given
        guard let vm = viewModel else {
            XCTFail("Viewmodel is nil")
            return
        }
        
        vm.textInput = "a"
        vm.arrayOfButtonTypes = [.add]
        
        // When
        vm.handleButtonPressed(buttonType: .deleteButton)
        
        // Then
        
        XCTAssert(vm.textInput.isEmpty)
        XCTAssert(vm.arrayOfButtonTypes.isEmpty)
    }
    
    func test_CalculatorViewModel_handleClearButtonPressed_shouldClearTextInputArrayofInputTypesAndRunningTotal() {
        // Given
        guard let vm = viewModel else {
            XCTFail("Viewmodel is nil")
            return
        }
        
        vm.textInput = "2 + 2"
        vm.arrayOfButtonTypes = [.two, .add, .two]
        vm.runningTotal = "4"
        
        // When
        vm.handleButtonPressed(buttonType: .clear)
        
        // Then
        
        XCTAssert(vm.textInput.isEmpty)
        XCTAssert(vm.arrayOfButtonTypes.isEmpty)
        XCTAssert(vm.runningTotal.isEmpty)
    }

}
