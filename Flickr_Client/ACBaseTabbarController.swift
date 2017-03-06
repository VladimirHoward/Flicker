//
//  ACBaseTabbarController.swift
//  Flickr_Client
//
//  Created by Gregory House on 15.10.16.
//  Copyright © 2016 vvz. All rights reserved.
//


import UIKit
import MWPhotoBrowser

class ACBaseTabbarController: UITabBarController
{
    override func viewDidAppear(_ animated: Bool)
    {
        
        assignValues ()
        loadData(withOffset: 0, count: 10)
        super.viewDidAppear(animated)
        
    }
}
//MARK: работа с загрузкой данных
extension ACBaseTabbarController
{
    
    func loadData (withOffset offset: Int, count: Int)
    {
        ACPostsManager.getPosts(withOffset: offset, count: count, success: {
            
            DispatchQueue.main.async
                {
                    self.propagateUpdates()
            }
            
            
        }) { (errorCode) in
            
        }
    }
    
    func assignValues ()
    {
        if let controllers = self.viewControllers as? [ACBaseViewController]
        {
            for controller in controllers
            {
                controller.parentTabbarController = self
            }
        }
    }
    
    
    private func propagateUpdates ()
    {
        if let controllers = self.viewControllers as? [ACBaseViewController]
        {
            for controller in controllers
            {
                controller.reloadView()
            }
        }
    }
}

//MARK: показ фото
extension ACBaseTabbarController: MWPhotoBrowserDelegate
{

    func setUpAndPresentMWPhotoBrowser(forModelIndex modelIndex: Int)
    {
        let browser = MWPhotoBrowser(delegate: self)
        browser?.setCurrentPhotoIndex(UInt(modelIndex))
        
        self.navigationController?.pushViewController(browser!, animated: true)

//        self.parentTabbarController?.navigationController!.pushViewController(browser!, animated: true)

    }

    func numberOfPhotos(in photoBrowser: MWPhotoBrowser!) -> UInt
    {
        return UInt(ACPostsManager.modelsCount())
    }

    func photoBrowser(_ photoBrowser: MWPhotoBrowser!, photoAt index: UInt) -> MWPhotoProtocol!
    {
        return ACPostsManager.getModel(atIndex: Int(index))
    }

}

