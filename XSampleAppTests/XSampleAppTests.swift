//
//  XSampleAppTests.swift
//  XSampleAppTests
//
//  Created by Masaya Suzuki on 2025/03/15.
//

import XCTest
@testable import XSampleApp

final class XSampleAppTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
    // 文字数カウントが140のときに文字数判断真偽値(isTextEnable)が"true"で返ってくる
    func testpostRegulationCheck2_1() throws {
        let pvc = PostViewController()
        let textCount = pvc.textCount1To140(textCount2: 140)
        XCTAssertTrue(textCount)
    }
    // 文字数カウントが140のときに文字数判断真偽値(isTextEnable)が"false"で返ってくる
    func testpostRegulationCheck2_2() throws {
        let pvc = PostViewController()
        let textCount = pvc.textCount1To140(textCount2: 141)
        XCTAssertFalse(textCount)
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
