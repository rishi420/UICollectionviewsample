//
//  CustomCollectionViewController.swift
//  MultiDirectionCollectionView
//
//  Created by Kyle Andrews on 3/21/15.
//  Copyright (c) 2015 Credera. All rights reserved.
//

import UIKit

let reuseIdentifier = "customCell"
let url = "http://www.mocky.io/v2/57a9678f110000a90b165a27"

class CustomCollectionViewController: UICollectionViewController {

    var items = [Item]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        getDataFromServer()
    }
    
    func getDataFromServer() {
        
        HttpManager.getRequest(url, parameter: .None) { [weak self] (responseData, errorMessage) -> () in
            
            guard let strongSelf = self else { return }
            
            guard let responseData = responseData else {
                print("Get request error \(errorMessage)")
                return
            }
            
            guard let customCollectionViewLayout = strongSelf.collectionView?.collectionViewLayout as? CustomCollectionViewLayout  else { return }
            
            strongSelf.items = responseData
            customCollectionViewLayout.dataSourceDidUpdate = true
            
            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                strongSelf.collectionView!.reloadData()
            })
        }
    }
}

// MARK: UICollectionViewDataSource
extension CustomCollectionViewController {
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return items.count
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items[section].services.count + 1
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! CustomCollectionViewCell
        
        if indexPath.item == 0 {
            cell.label.text = items[indexPath.section].base
        } else {
            cell.label.text = items[indexPath.section].services[indexPath.item - 1]
        }
        
        return cell
    }
}

// MARK: UICollectionViewDelegate
extension CustomCollectionViewController {
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        // You must call super to animate selection
        
        print("Selected = \(indexPath.section)/Item \(indexPath.item)")
    }
}