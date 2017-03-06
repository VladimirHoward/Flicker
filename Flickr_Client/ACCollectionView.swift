//
//  ACCollectionView.swift
//  Flickr_Client
//
//  Created by Gregory House on 15.10.16.
//  Copyright © 2016 vvz. All rights reserved.
//

import UIKit
import MWPhotoBrowser

private let kCollectionViewCellXIBName = "ACPostsCollectionViewCell"
private let kCollectionViewCellReuseIdentifier = "kCollectionViewCellReuseIdentifier"

class ACCollectionViewController : ACBaseViewController
{
    
    @IBOutlet weak var collectionView: UICollectionView?
    
    override func viewDidLoad()
    {
        
        super.viewDidLoad()
        
        collectionView?.register( UINib(nibName: kCollectionViewCellXIBName, bundle: nil), forCellWithReuseIdentifier: kCollectionViewCellReuseIdentifier)

        collectionView?.dataSource = self
        collectionView?.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        collectionView?.reloadData()
    }
    
    override func reloadView() {
        self.collectionView?.reloadData()
        
    }
    
}
//MARK: процедуры интерфейса UICollectionViewDataSource, UICollectionViewDelegate
extension ACCollectionViewController : UICollectionViewDataSource, UICollectionViewDelegate
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ACPostsManager.modelsCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCollectionViewCellReuseIdentifier, for: indexPath) as! ACPostsCollectionViewCell
        
        let model = ACPostsManager.getModel(atIndex: indexPath.row)
        
        
        
        cell.configureSelfWithDataModel(model: model)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath)
    {
        
        if ( indexPath.row == ACPostsManager.modelsCount() - 1)
        {
            parentTabbarController?.loadData(withOffset: ACPostsManager.modelsCount() / 10 + 1, count: 10)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        collectionView.deselectItem(at: indexPath, animated: true)
        parentTabbarController?.setUpAndPresentMWPhotoBrowser(forModelIndex: indexPath.row)
    }
    
}

//MARK: реализаци динамической ширины ячейки
extension ACCollectionViewController: UICollectionViewDelegateFlowLayout
{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        
        let width = self.collectionView?.contentSize.width
        
        return CGSize(width: width! / 3 - 4, height: width! / 3 - 4)
       
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat
    {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat
    {
        return 4
    }
    
}






