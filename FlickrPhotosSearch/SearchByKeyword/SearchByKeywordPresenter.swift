//
//  SearchByKeywordPresenter.swift
//  FlickrPhotosSearch
//
//  Created by Marian on 2/16/17.
//  Copyright © 2017 Marian. All rights reserved.
//

import UIKit

class SearchByKeywordPresenter: SearchByKeywordViewPresenterProtocol, SearchByKeywordServicePresenterProtocol{
    
    weak var SearchByKeywordView : SearchByKeywordPresenterViewProtocol?
    var service : SearchByKeywordPresenterServiceProtocol?
    
    var pageIndex = 1
    var keyword : String?
    required init(view: SearchByKeywordPresenterViewProtocol) {
        self.SearchByKeywordView = view
        
    }
    
    func searchWithKeyword(keyword : String){
        Photo.deleteAllPhotos()
        
        self.keyword = keyword
        service = SearchByKeywordService(presenter: self)
        service?.searchByKeyword(keyword: keyword, pageNumber: pageIndex)
        pageIndex = pageIndex + 1
    }
    
    func loadMorePhotos(){
        if service == nil {
            service = SearchByKeywordService(presenter: self)
            
        }
        service?.searchByKeyword(keyword: keyword!, pageNumber: pageIndex)
        pageIndex = pageIndex + 1
    }
    
    func setSearchResults(photoArray : [Photo]){
        SearchByKeywordView?.showSearchResult(photoArray: photoArray)
        
    }
    
    func handelError(error : Error){
        SearchByKeywordView?.showErrorMsg(msg: error.localizedDescription)
    }
    
    func getOfflinePhotos(){
        if service == nil {
            service = SearchByKeywordService(presenter: self)
            
        }
        service?.getOfflinePhotos()
    }
    
    
}
