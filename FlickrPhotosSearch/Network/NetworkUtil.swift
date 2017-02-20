//
//  NetworkUtil.swift
//  FlickrPhotosSearch
//
//  Created by Marian on 2/19/17.
//  Copyright © 2017 Marian. All rights reserved.
//

import UIKit
import Reachability
class NetworkUtil: NSObject {
    
    static func getNetworkStatus() -> Bool{
        let reachability  = Reachability.init(hostName: "www.google.com")
        
        if (reachability?.isReachable())! {
            return true
        }else{
            return false
        }
        
    }
}
