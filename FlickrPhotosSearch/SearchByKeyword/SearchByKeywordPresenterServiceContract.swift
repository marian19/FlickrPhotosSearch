//
//  SearchByKeywordPresenterServiceProtocol.swift
//  FlickrPhotosSearch
//
//  Created by Marian on 2/16/17.
//  Copyright © 2017 Marian. All rights reserved.
//

import Foundation


protocol SearchByKeywordServicePresenterProtocol {
    func setSearchResults(photoArray : [Photo])
    func handelError(error : Error)

    
}

protocol SearchByKeywordPresenterServiceProtocol {
    func searchByKeyword(keyword : String, pageNumber : Int)
    init(presenter: SearchByKeywordServicePresenterProtocol)

}
