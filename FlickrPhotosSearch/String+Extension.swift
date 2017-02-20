//
//  String+Extension.swift
//  FlickrPhotosSearch
//
//  Created by Marian on 2/20/17.
//  Copyright © 2017 Marian. All rights reserved.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
}
