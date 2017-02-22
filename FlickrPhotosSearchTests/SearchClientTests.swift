//
//  SearchClientTests.swift
//  FlickrPhotosSearch
//
//  Created by Marian on 2/20/17.
//  Copyright © 2017 Marian. All rights reserved.
//

import XCTest
@testable import FlickrPhotosSearch

class SearchClientTests: XCTestCase {
    
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testServiceCallBack() {
        let searchClient = SearchClient()
        
        
        let expectation = self.expectation(description: "SearchClient search Photos By Keyword and runs the callback closure")
        searchClient.searchPhotosByKeyword(keyword: "sky", pageNumber: 1, success: { photos in
            XCTAssertNotNil(photos)
            expectation.fulfill()
            
        }, failure: { error in
            
        })
        
        waitForExpectations(timeout: 1) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
        
    }
    
}

class SearchClient {
    
    func searchPhotosByKeyword(keyword: String, pageNumber : Int , success: @escaping ([Photo]) -> Void, failure:@escaping (Error) -> Void){
        let qualityOfServiceClass = DispatchQoS.QoSClass.background
        let backgroundQueue = DispatchQueue.global(qos: qualityOfServiceClass)
        backgroundQueue.async {
            let photos : [Photo] = []
            success(photos)
        }
    }
}
