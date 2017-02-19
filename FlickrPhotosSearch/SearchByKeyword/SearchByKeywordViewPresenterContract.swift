//
//  SearchByKeywordViewPresenter.swift
//  FlickrPhotosSearch
//
//  Created by Marian on 2/16/17.
//  Copyright © 2017 Marian. All rights reserved.
//

import UIKit

protocol SearchByKeywordViewPresenterProtocol {
    func searchWithKeyword(keyword : String)
    init(view: SearchByKeywordPresenterViewProtocol)
    func loadMorePhotos()

}

protocol SearchByKeywordPresenterViewProtocol {
    func showSearchResult(photoArray : [Photo])
    func showErrorMsg(msg : String)

}
