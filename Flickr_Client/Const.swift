//
//  Const.swift
//  Flickr_Client
//
//  Created by Gregory House on 24.09.16.
//  Copyright © 2016 vvz. All rights reserved.
//

import Foundation
import UIKit

class Const
{
    class URLConst
    {
        static let kBaseURL = "https://api.flickr.com/services/rest/"
        
        class Arguments
        {
            static let kMethod : NSString = "method"
            static let kAPIKey : NSString = "api_key"
            static let kFormat : NSString = "format"
            static let kNoJSONCallback  : NSString = "nojsoncallback"
            static let kPageNumber  : NSString = "page"
            static let kPageSize : NSString = "per_page"
        }
    }
    
    class Colors
    {
        static let kcolor1 = UIColor.black
        static let kcolor2 = UIColor.clear
    }
}
