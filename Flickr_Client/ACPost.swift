//
//  ACPost.swift
//  Flickr_Client
//
//  Created by Gregory House on 01.10.16.
//  Copyright © 2016 vvz. All rights reserved.
//

import Foundation
import MWPhotoBrowser
import SDWebImage

class ACPost: NSObject, MWPhotoProtocol
{
    
    var postID: String
    var authorName: String
    var postName: String
    var postPictureURL: String
    init (withPostID postIDa : String, authorNamea: String, postNamea: String, postPictureURLa: String)
    {
        self.postID = postIDa
        self.authorName = authorNamea
        self.postName = postNamea
        self.postPictureURL = postPictureURLa
    }
    
    var underlyingImage: UIImage? = nil
    
    func loadUnderlyingImageAndNotify()
    {
        SDWebImageManager.shared().downloadImage(with: URL(string: postPictureURL)!, options: .retryFailed, progress: nil) { (image, error, cacheType, cached, url) in
            
            if ( image != nil)
            {
                self.underlyingImage = image
                self.reportImageLoaded()
            }
        }
    }
    
    func performLoadUnderlyingImageAndNotify()
    {
        
    }
    
    func unloadUnderlyingImage()
    {
        underlyingImage = nil
    }
    
    private func reportImageLoaded()
    {
        DispatchQueue.main.async
        {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "MWPHOTO_LOADING_DID_END_NOTIFICATION"), object: self)
        }
    }
}





