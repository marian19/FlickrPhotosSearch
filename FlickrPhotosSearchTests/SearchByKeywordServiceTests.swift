//
//  SearchByKeywordServiceTests.swift
//  FlickrPhotosSearch
//
//  Created by Marian on 2/20/17.
//  Copyright © 2017 Marian. All rights reserved.
//

import XCTest
@testable import FlickrPhotosSearch

class SearchByKeywordServiceTests: XCTestCase {
    
    var searchByKeywordService : SearchByKeywordService!
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let navigationController = storyboard.instantiateInitialViewController() as! UINavigationController
        
       let view = navigationController.viewControllers.first as! SearchByKeywordViewController!
        
        let presenter = SearchByKeywordPresenter(view: view!)
        searchByKeywordService = SearchByKeywordService(presenter: presenter)
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testServiceCallBack() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // 1. Define an expectation
        let expectation = expectation(description: "SomeService does stuff and runs the callback closure")
        
    }
    
    
    
}
