//
//  SearchByKeywordService.swift
//  FlickrPhotosSearch
//
//  Created by Marian on 2/16/17.
//  Copyright © 2017 Marian. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class SearchByKeywordService: SearchByKeywordPresenterServiceProtocol {
    
    var apiClient = HTTPClient.sharedInstance
    var searchByKeywordPresenter : SearchByKeywordServicePresenterProtocol
    
    
    func searchByKeyword(keyword : String , pageNumber : Int){
        
        self.searchPhotosByKeyword(keyword: keyword, pageNumber: pageNumber ,success: {  photoArray in
            
            self.searchByKeywordPresenter.setSearchResults(photoArray: photoArray)
            
            },failure: { [weak self] response , error in
                
                self?.searchByKeywordPresenter.handelError(error: error)
                
        })
    }
    
    required init(presenter: SearchByKeywordServicePresenterProtocol){
        self.searchByKeywordPresenter = presenter
    }
    
    
    func searchPhotosByKeyword(keyword: String, pageNumber : Int , success: @escaping ([Photo]) -> Void, failure:@escaping (HTTPURLResponse ,Error) -> Void){
        
        //request url
        let url = Constants.WEBSERVICE_BASE_URL
        let parameters: [String: Any] = [
            "method": Constants.SEARCH_BY_KEYWORD,
            "api_key": Constants.API_KEY,
            "text"  :keyword,
            "per_page" : 20,
            "page" : pageNumber,
            "format" : "json" ,
            "nojsoncallback" : 1]
        
        apiClient.executeGetRequest(url: url, parameters: parameters, success: { (responseObject) -> Void in
            
            let json = JSON(responseObject)
            var photos:[Photo] = []
            
            for item in json["photos"]["photo"].arrayValue{
                print(item["owner"].stringValue)
                let photo = Photo.createPhotoFrom(jsonDictionary: item)
                photos.append(photo)
                
            }
            success(photos)
            
        },failure: {response , error in
            failure(response, error)
        })
        
        
    }
}
