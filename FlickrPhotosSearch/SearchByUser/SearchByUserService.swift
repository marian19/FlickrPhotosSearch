//
//  SearchByUserService.swift
//  FlickrPhotosSearch
//
//  Created by Marian on 2/16/17.
//  Copyright © 2017 Marian. All rights reserved.
//

import UIKit


class SearchByUserService: SearchByUserPresenterServiceProtocol {
    
    weak var searchByUserPresenter : SearchByUserServicePresenterProtocol?
    
    
    
    func searchByUser(ownerID : String , pageNumber : Int){
        let searchClient = SearchClient()
        
        searchClient.searchPhotosByOwnerId(ownerID: ownerID, pageNumber: pageNumber ,success: { [weak self] photoArray in
            
            self?.searchByUserPresenter?.setSearchResults(photoArray: photoArray)
            
            },failure: { [weak self]  error in
                
                self?.searchByUserPresenter?.handelError(error: error)
                
        })
        
    }
    
    required init(presenter: SearchByUserServicePresenterProtocol){
        self.searchByUserPresenter = presenter
    }
    
    
    
}
