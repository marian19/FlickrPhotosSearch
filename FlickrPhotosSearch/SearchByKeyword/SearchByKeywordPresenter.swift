//
//  SearchByKeywordPresenterImplementation.swift
//  FlickrPhotosSearch
//
//  Created by Marian on 2/16/17.
//  Copyright © 2017 Marian. All rights reserved.
//

import UIKit

class SearchByKeywordPresenter: SearchByKeywordViewPresenterProtocol, SearchByKeywordServicePresenterProtocol{

    var SearchByKeywordView : SearchByKeywordPresenterViewProtocol
    
    var pageIndex = 1
    var keyword : String?
    required init(view: SearchByKeywordPresenterViewProtocol) {
        self.SearchByKeywordView = view
        Photo.deleteAllPhotos()
        
    }
    
    func searchWithKeyword(keyword : String){
        self.keyword = keyword
    let service = SearchByKeywordService(presenter: self)
        
        service.searchByKeyword(keyword: keyword, pageNumber: pageIndex)
        pageIndex = pageIndex + 1
    }
    
    func loadMorePhotos(){
        let service = SearchByKeywordService(presenter: self)
        service.searchByKeyword(keyword: keyword!, pageNumber: pageIndex)
        pageIndex = pageIndex + 1
    }

    func setSearchResults(photoArray : [Photo]){
    SearchByKeywordView.showSearchResult(photoArray: photoArray)
        
    }
    
    func handelError(error : Error){
    
    }

}
