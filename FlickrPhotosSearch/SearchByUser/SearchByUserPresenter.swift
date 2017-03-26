//
//  SearchByUserPresenter.swift
//  FlickrPhotosSearch
//
//  Created by Marian on 2/16/17.
//  Copyright © 2017 Marian. All rights reserved.
//

import UIKit

class SearchByUserPresenter: SearchByUserViewPresenterProtocol, SearchByUserServicePresenterProtocol{
    
    weak var SearchByUserView : SearchByUserPresenterViewProtocol?
    var service : SearchByUserPresenterServiceProtocol?
    var pageIndex = 1
    var ownerID : String?
    required init(view: SearchByUserPresenterViewProtocol) {
        self.SearchByUserView = view
        
    }
    
    func searchWithUser(ownerID : String){
        
        self.SearchByUserView?.showProgressBar()
        self.ownerID = ownerID
        service = SearchByUserService(presenter: self)
        service?.searchByUser(ownerID: ownerID, pageNumber: pageIndex)
        pageIndex = pageIndex + 1
    }
    
    func loadMorePhotos(){
        self.SearchByUserView?.showProgressBar()
        
        if service == nil {
            service = SearchByUserService(presenter: self)
            
        }
        service?.searchByUser(ownerID: ownerID!, pageNumber: pageIndex)
        pageIndex = pageIndex + 1
    }
    
    func setSearchResults(photoArray : [Photo]){
        
        self.SearchByUserView?.hideProgressBar()
        SearchByUserView?.showSearchResult(photoArray: photoArray)
        
    }
    
    func handelError(error : Error){
        
        self.SearchByUserView?.hideProgressBar()
        SearchByUserView?.showErrorMsg(msg: error.localizedDescription)
    }
    
    
    
}
