//
//  NYTTests.swift
//  NYTTests
//
//  Created by Yusuf Yıldız on 15.02.2019.
//  Copyright © 2019 Yusuf Yıldız. All rights reserved.
//

import XCTest
@testable import NYT

class NYTTests: XCTestCase {

    let featuredArticleJSON = [Constants.url: "https://www.google.com",
                               Constants.typeOfMaterial: "Article",
                               Constants.snippet: "Unit Test Snippet",
                               Constants.abstract: "Unit Test Abstract",
                               Constants.leadParagraph: "Unit Test Lead Paragraph",
                               Constants.section: "Unit Test Section",
                               Constants.title: "Unit Test Title",
                               Constants.publishedDate: "2019-02-15"]


    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    func testFeaturedArticle() {
        do {
            _ = try FeaturedArticle(json: featuredArticleJSON)
        } catch {
            XCTAssert(false)
        }
    }
    

}
