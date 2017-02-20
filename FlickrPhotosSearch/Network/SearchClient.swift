//
//  SearchClient.swift
//  FlickrPhotosSearch
//
//  Created by Marian on 2/19/17.
//  Copyright © 2017 Marian. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class SearchClient: NSObject {
    var apiClient = HTTPClient.sharedInstance

    func searchPhotosByKeyword(keyword: String, pageNumber : Int , success: @escaping ([Photo]) -> Void, failure:@escaping (Error) -> Void){
        
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
            
        },failure: { error in
            failure( error)
        })
        
        
    }
    
    func searchPhotosByOwnerId(ownerID: String, pageNumber : Int , success: @escaping ([Photo]) -> Void, failure:@escaping (Error) -> Void){
        
        //request url
        let url = Constants.WEBSERVICE_BASE_URL
        let parameters: [String: Any] = [
            "method": Constants.SEARCH_BY_OWNER,
            "api_key": Constants.API_KEY,
            "user_id"  :ownerID,
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
            
        },failure: { error in
            failure( error)
        })
        
        
    }
}
