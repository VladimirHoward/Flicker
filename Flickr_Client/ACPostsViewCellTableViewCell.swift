//
//  ACPostsViewCellTableViewCell.swift
//  Flickr_Client
//
//  Created by Gregory House on 01.10.16.
//  Copyright © 2016 vvz. All rights reserved.
//

import UIKit
import SDWebImage

class ACPostsViewCellTableViewCell: UITableViewCell
{
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var postTitleLabel: UILabel!
    @IBOutlet weak var authorNameLable: UILabel!
    @IBOutlet weak var scrimView: UIView!
    
    var gradientLayer : CAGradientLayer?
}

//MARK: настройка клетки
extension ACPostsViewCellTableViewCell
{
    func configureSelf (withDataModel model: ACPost)
    {
        if ( gradientLayer == nil )
        {
            self.setNeedsLayout()
            self.layoutIfNeeded()

            let layer = CAGradientLayer()
            layer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
            layer.frame = CGRect(x: 0.0, y: 0.0, width: scrimView.frame.width, height: scrimView.frame.height)
            

            scrimView.layer.addSublayer(layer)
            gradientLayer = layer
        }
        
        photoImageView.sd_setImage(with: NSURL(string: model.postPictureURL) as! URL)
        postTitleLabel.text = model.postName
        authorNameLable.text = model.authorName
    }
}





