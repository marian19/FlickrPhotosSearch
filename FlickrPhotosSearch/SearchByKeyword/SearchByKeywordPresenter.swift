//
//  SearchByKeywordPresenter.swift
//  FlickrPhotosSearch
//
//  Created by Marian on 2/16/17.
//  Copyright © 2017 Marian. All rights reserved.
//

import UIKit

class SearchByKeywordPresenter: SearchByKeywordViewPresenterProtocol, SearchByKeywordServicePresenterProtocol{
    
    weak var searchByKeywordView : SearchByKeywordPresenterViewProtocol?
    var service : SearchByKeywordPresenterServiceProtocol?
    
    var pageIndex = 1
    var keyword : String?
    required init(view: SearchByKeywordPresenterViewProtocol) {
        self.searchByKeywordView = view
        
        
    }
    
    func searchingWithKeyword(keyword : String){
        self.keyword = keyword
        self.searchByKeywordView?.showProgressBar()
        let isNetworkValiable = NetworkUtil.getNetworkStatus()
        
        if isNetworkValiable == false {
            searchByKeywordView?.hideProgressBar()
            
            searchByKeywordView?.showErrorMsg(msg: "OfflineMessage".localized )
            
        }else{
            
            getingOnlinePhotos()
        }
    }
    
    func loadingMorePhotos(){
        self.searchByKeywordView?.showProgressBar()
        
        if service == nil {
            service = SearchByKeywordService(presenter: self)
            
        }
        service?.searchByKeyword(keyword: keyword!, pageNumber: pageIndex)
        pageIndex = pageIndex + 1
    }
    
    func setSearchResults(photoArray : [Photo]){
        searchByKeywordView?.hideProgressBar()
        searchByKeywordView?.showSearchResult(photoArray: photoArray)
        
    }
    
    func handelError(error : Error){
        searchByKeywordView?.hideProgressBar()
        
        searchByKeywordView?.showErrorMsg(msg: error.localizedDescription)
    }
    
    func getingOnlinePhotos(){
        Photo.deleteAllPhotos()
        
        service = SearchByKeywordService(presenter: self)
        service?.searchByKeyword(keyword: keyword!, pageNumber: pageIndex)
        pageIndex = pageIndex + 1
    }
    
    
    
    func getingCachedPhotos(){
        self.searchByKeywordView?.showProgressBar()
        
        if service == nil {
            service = SearchByKeywordService(presenter: self)
            
        }
        service?.getOfflinePhotos()
    }
    
}
