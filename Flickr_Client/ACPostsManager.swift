//
//  ACPostsManager.swift
//  Flickr_Client
//
//  Created by Gregory House on 01.10.16.
//  Copyright © 2016 vvz. All rights reserved.
//

import Foundation

class ACPostsManager
{
    
    static var postsArray = [ACPost]()
    
    
    class func getModel (atIndex index: Int) -> ACPost
    {
        return postsArray[index]
    }
    
    class func modelsCount () -> Int
    {
        return postsArray.count
    }
    
    
    
}

//MARK: Загрузка данных из интернета
extension ACPostsManager
{
    class func getPosts ( withOffset offset: Int, count: Int, success : @escaping () -> Void, failure: @escaping ( _ errorCode: Int) -> Void) -> Void
    {
        
        API_WRAPPER.getPost(withPageNumber: offset, pageSize: count, successBlock: { (jsonResponse) in
            
            if let postsArray1 = jsonResponse["photos"] as? NSDictionary
            {
                if let rawpostsArray = postsArray1["photo"] as? [NSDictionary]
                {
                    for i in 0..<rawpostsArray.count
                    {
                        let post = rawpostsArray[i]
                        
                        let postID = post["id"] as! NSString
                        let authorName = post["owner"] as! NSString
                        let title = post["title"] as! NSString
                        let farm = (post ["farm"] as! NSNumber).intValue
                        let server = (post ["server"] as! NSString)
                        let secret = post["secret"] as! NSString
                        let photoURL = "https://farm\(farm).staticflickr.com/\(server)/\(postID)_\(secret)_z.jpg"
                        
                        let localPost = ACPost(withPostID: postID as String, authorNamea: authorName as String, postNamea: title as String, postPictureURLa: photoURL)
                        
                        postsArray.append(localPost)
                        
//                        print("\n\n\nпост номер \(i) - \(post)\n\n\n\n юрл картинки - \(photoURL) \n\n\n\n")
                    }
                    success()
                }
            }
            
            }, failureBlock: failure)
    }
}
