//
//  ViewController.swift
//  Flickr_Client
//
//  Created by Gregory House on 24.09.16.
//  Copyright © 2016 vvz. All rights reserved.
//

import UIKit
import MWPhotoBrowser

private let kpostsCellXIBName = "ACPostsViewCellTableViewCell"
private let kPostsCellIndentifier = "kPostsCellIdentifier"

class ViewController: ACBaseViewController
{

    @IBOutlet weak var tableView: UITableView?
    
    override func viewDidLoad()
    {
        self.tableView?.dataSource = self
        self.tableView?.delegate = self
        super.viewDidLoad()
        self.tableView?.register( UINib(nibName: kpostsCellXIBName, bundle: nil), forCellReuseIdentifier: kPostsCellIndentifier)
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        tableView?.reloadData()
    }
    
    override func reloadView()
    {
        tableView?.reloadData()
    }
}

//MARK: реализация функции протокола UITableViewDataSouce
extension ViewController : UITableViewDataSource, UITableViewDelegate
{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
        let contentOffset = scrollView.contentOffset
        
        print("сдвиг \(contentOffset.y)")
        
        //begin - var end - var decelerate  - true/false -> count var1 var2 -> логика тут   
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return ACPostsManager.modelsCount()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 174.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let model = ACPostsManager.getModel(atIndex: indexPath.row)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: kPostsCellIndentifier, for: indexPath) as! ACPostsViewCellTableViewCell
       
        cell.configureSelf(withDataModel: model)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if ( indexPath.row == ACPostsManager.modelsCount() - 1)
        {
            parentTabbarController?.loadData(withOffset: ACPostsManager.modelsCount() / 10 + 1, count: 10)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        parentTabbarController?.setUpAndPresentMWPhotoBrowser(forModelIndex: indexPath.row)
    }
    
}



//событие сколько пользователь отскроллил вверх и вниз - таббар убрать нарпавление, сместился верх или вниз, поменял направление




