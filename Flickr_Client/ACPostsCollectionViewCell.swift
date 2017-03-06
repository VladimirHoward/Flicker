//
//  ACPostsCollectionViewCell.swift
//  Flickr_Client
//
//  Created by Gregory House on 15.10.16.
//  Copyright © 2016 vvz. All rights reserved.
//

import UIKit

class ACPostsCollectionViewCell: UICollectionViewCell
{

    @IBOutlet weak var postPhotoImageView: UIImageView!
    
    func configureSelfWithDataModel (model: ACPost)
    {
        postPhotoImageView.sd_setImage(with: NSURL(string: model.postPictureURL) as! URL)
    }

}
