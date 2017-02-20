//
//  SearchByKeywordService.swift
//  FlickrPhotosSearch
//
//  Created by Marian on 2/16/17.
//  Copyright © 2017 Marian. All rights reserved.
//

import UIKit


class SearchByKeywordService: SearchByKeywordPresenterServiceProtocol {
    
    weak var searchByKeywordPresenter : SearchByKeywordServicePresenterProtocol?
    
    func getOfflinePhotos(){
        let photos = Photo.getAllPhotos()
        self.searchByKeywordPresenter?.setSearchResults(photoArray: photos)
    }
    
    func searchByKeyword(keyword : String , pageNumber : Int){
        let searchClient = SearchClient()
        
            searchClient.searchPhotosByKeyword(keyword: keyword, pageNumber: pageNumber ,success: { [weak self] photoArray in
                
                self?.searchByKeywordPresenter?.setSearchResults(photoArray: photoArray)
                
                },failure: { [weak self]  error in
                    
                    self?.searchByKeywordPresenter?.handelError(error: error)
                    
            })
        
    }
    
    required init(presenter: SearchByKeywordServicePresenterProtocol){
        self.searchByKeywordPresenter = presenter
    }
    
    
   
}
