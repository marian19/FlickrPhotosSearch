//
//  SearchByKeywordPresenterServiceProtocol.swift
//  FlickrPhotosSearch
//
//  Created by Marian on 2/16/17.
//  Copyright © 2017 Marian. All rights reserved.
//

import Foundation


protocol SearchByUserServicePresenterProtocol: class {
    func setSearchResults(photoArray : [Photo])
    func handelError(error : Error)

    
}

protocol SearchByUserPresenterServiceProtocol : class {
    func searchByUser(ownerID : String, pageNumber : Int )
    init(presenter: SearchByUserServicePresenterProtocol)

}
