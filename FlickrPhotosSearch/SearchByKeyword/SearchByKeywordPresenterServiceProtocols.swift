//
//  SearchByKeywordPresenterServiceProtocols.swift
//  FlickrPhotosSearch
//
//  Created by Marian on 2/16/17.
//  Copyright © 2017 Marian. All rights reserved.
//

import Foundation


protocol SearchByKeywordServicePresenterProtocol: class {
    
    func setSearchResults(photoArray : [Photo])
    func handelError(error : Error)
    
}

protocol SearchByKeywordPresenterServiceProtocol : class {
    
    func searchByKeyword(keyword : String, pageNumber : Int )
    func getOfflinePhotos()
    init(presenter: SearchByKeywordServicePresenterProtocol)
    
}
