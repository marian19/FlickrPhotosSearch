//
//  HTTPClient.swift
//  FlickrPhotosSearch
//
//  Created by Marian on 2/16/17.
//  Copyright © 2017 Marian. All rights reserved.
//

import UIKit
import Alamofire

class HTTPClient: NSObject {

    static let sharedInstance =  HTTPClient()
    
    
    private override init() {
        
    }
    
    func executeGetRequest(url:String,parameters: Parameters?,success:@escaping (Any) -> Void, failure:@escaping ( Error) -> Void){
        Alamofire.request(url, parameters: parameters).responseJSON { (response:DataResponse<Any>) in
            
            
            switch(response.result) {
            case .success(_):
                if let data = response.result.value{
                    print(response.result.value!)
                    success(data)
                    
                }
                break
                
            case .failure(_):
                print(response.result.error!)
                failure(response.result.error!)
                
                break
                
            }
        }
    }
}
