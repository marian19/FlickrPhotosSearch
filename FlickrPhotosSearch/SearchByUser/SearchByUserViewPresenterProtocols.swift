//
//  SearchByUserViewPresenterProtocols.swift
//  FlickrPhotosSearch
//
//  Created by Marian on 2/16/17.
//  Copyright © 2017 Marian. All rights reserved.
//

import UIKit

protocol SearchByUserViewPresenterProtocol : class{
    func searchWithUser(ownerID : String)
    func loadMorePhotos()
    
}

protocol SearchByUserPresenterViewProtocol : class{
    func showSearchResult(photoArray : [Photo])
    func showErrorMsg(msg : String)
    func showProgressBar()
    func hideProgressBar()
}
