//
//  FlickrPhotosSearchTests.swift
//  FlickrPhotosSearchTests
//
//  Created by Marian on 2/16/17.
//  Copyright © 2017 Marian. All rights reserved.
//

import XCTest
@testable import FlickrPhotosSearch

class FlickrPhotosSearchTests: XCTestCase {
    var viewController: SearchByKeywordViewController!
    
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let navigationController = storyboard.instantiateInitialViewController() as! UINavigationController
        
        viewController = navigationController.viewControllers.first as! SearchByKeywordViewController!
        
        UIApplication.shared.keyWindow!.rootViewController = viewController
        
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        viewController = nil
    }
    
    func testIBOutlest() {
        XCTAssertNotNil((viewController.tableView ), "tableView not connected in storyboard")
        XCTAssertNotNil((viewController.searchBar), "seaarchBar not connected in storyboard")
        
        
    }
    
    func testProperties() {
        
        XCTAssertNotNil((viewController.presenter), "presenter not intialize")
        
    }
    
    func testGetOfflinePhotos() {
        viewController.viewDidLoad()
        let presenter = MockPresenter()
        viewController.presenter = presenter
        viewController.isNetworkValiable = false
        if viewController.isNetworkValiable  == false{
            presenter.getOfflinePhotos()
        }
        XCTAssertTrue(presenter.getOfflinePhotosGotCalled , "getOfflinePhotos should have been called")
        
        
    }
    
    func testSearchWithKeywordGotCalled() {
        let presenter = MockPresenter()
        viewController.presenter = presenter
        viewController.searchBarSearchButtonClicked(UISearchBar())
        XCTAssertTrue(presenter.searchWithKeywordGotCalled , "searchWithKeyword should have been called")
    }
    
    class MockPresenter: NSObject, SearchByKeywordViewPresenterProtocol {
        var getOfflinePhotosGotCalled = false
        var searchWithKeywordGotCalled = false
        
        func searchWithKeyword(keyword : String){searchWithKeywordGotCalled = true}
        func getOfflinePhotos(){ getOfflinePhotosGotCalled = true}
        func loadMorePhotos(){}
        
    }
    
    
}
