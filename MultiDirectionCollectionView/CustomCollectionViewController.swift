//
//  CustomCollectionViewController.swift
//  MultiDirectionCollectionView
//
//  Created by Kyle Andrews on 3/21/15.
//  Copyright (c) 2015 Credera. All rights reserved.
//

import UIKit

let reuseIdentifier = "customCell"

class CustomCollectionViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        //#warning Incomplete method implementation -- Return the number of sections
        return 8
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //#warning Incomplete method implementation -- Return the number of items in the section
        return 20
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! CustomCollectionViewCell
    
        // Configure the cell
        cell.label.text = "Sec \(indexPath.section)/Item \(indexPath.item)"
        
        //cell.label.alpha = 0
       // cell.layer.borderWidth = 0.0
        
        
        if indexPath.section == 0 && indexPath.item == 0 {
         
            cell.label.text = "D"
            
        }else if indexPath.section == 1 && indexPath.item == 0 {
            
            cell.label.text = "E"
            
        }else if indexPath.section == 2 && indexPath.item == 0 {
            
            cell.label.text = "F"
            
        }else if indexPath.section == 3 && indexPath.item == 0 {
            
            cell.label.text = "G"
            
        }else if indexPath.section == 4 && indexPath.item == 0 {
            
            cell.label.text = "H"
            
        }else if indexPath.section == 5 && indexPath.item == 0 {
            
            cell.label.text = "I"
            
        }else if indexPath.section == 6 && indexPath.item == 0 {
            
            cell.label.text = "J"
            
        }else if indexPath.section == 7 && indexPath.item == 0 {
            
            cell.label.text = "K"
            
        }else{
            
            
        }
      
    
        return cell
    }
    
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        // You must call super to animate selection
        
        print("Selected = \(indexPath.section)/Item \(indexPath.item)")
        
      
    }

    // MARK: UICollectionViewDelegate



}
