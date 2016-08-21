//
//  CustomCollectionViewController.swift
//  MultiDirectionCollectionView
//
//  Created by Kyle Andrews on 3/21/15.
//  Copyright (c) 2015 Credera. All rights reserved.
//

import UIKit

let reuseIdentifier = "customCell"
//let url = "http://www.mocky.io/v2/57a9678f110000a90b165a27"
let url = "http://scenear.com/iosapps/cinetime/test.json"

class CustomCollectionViewController: UICollectionViewController {

    var items = [Item]()
    
    var koltuksira = [""]
    var koltuksiraid = [""]
    
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
        
        cell.label.font.fontWithSize(12)
        cell.label.textColor = UIColor.whiteColor()
        
        if indexPath.item == 0 {
            
            cell.label.text = items[indexPath.section].base
            cell.label.frame.size.width = 30
            cell.label.frame.size.height = 30
            cell.label.layer.borderColor = UIColor.clearColor().CGColor
            cell.contentView.backgroundColor = UIColor.clearColor()
            
        } else {
            
            if let myStringc: String = items[indexPath.section].services[indexPath.item - 1] {
                var myStringArrc = myStringc.componentsSeparatedByString("*")
                
                let satimdurum:Int = Int(myStringArrc[3])!
                let sirano:Int = Int(myStringArrc[0])!
                
                if sirano == 1 || sirano == 2 {
                    
                    cell.label.backgroundColor = (satimdurum == 1) ?  UIColor.redColor() : UIColor.orangeColor()
                    cell.contentView.backgroundColor = (satimdurum == 1) ?  UIColor.redColor() : UIColor.greenColor()
                    cell.label.layer.borderColor = UIColor.blackColor().CGColor
                    cell.alpha = 1
                    
                    if sirano == 2 {
                        cell.frame.size.width = 80
                        cell.layer.frame.size.width = 80
                        CELL_WIDTH = 80.0
                        CELL_HEIGHT = 22.0
                        
                        if satimdurum == 1 {
                            
                            cell.label.alpha = 1
                            cell.label.layer.borderColor = UIColor.redColor().CGColor
                            cell.contentView.backgroundColor = UIColor.redColor()
                            cell.label.text = myStringArrc[1]
                            
                        }else{
                            
                            
                            
                            
                            
                            if myStringArrc[1] == "NULL"  {
                                cell.label.alpha = 0
                                cell.label.layer.borderColor = UIColor.clearColor().CGColor
                                cell.label.frame.size.width = 0
                                cell.label.frame.size.height = 0
                                cell.contentView.backgroundColor = UIColor.clearColor()
                            }else{
                                cell.label.alpha = 1
                                cell.label.backgroundColor = UIColor.orangeColor()//Or put orange color as per your logic based on myStringArrc
                                cell.label.frame.size.width = 40
                                cell.label.frame.size.height = 40
                                let color = koltuksiraid.contains(myStringc) ? UIColor(red: 62/256, green: 211/256, blue: 238/256, alpha: 1) : UIColor.orangeColor()
                                cell.contentView.backgroundColor = color //Or put orange color as per your logic based on myStringArrc
                                cell.label.text = myStringArrc[1]
                            }
                            
                            
                        }
                        
                        cell.label.text = "\(myStringArrc[1])-\(myStringArrc[5])"
                    }else{
                        
                        cell.frame.size.width = 40
                        cell.layer.frame.size.width = 40
                        CELL_HEIGHT = 22.0
                        CELL_WIDTH = 40
                        
                        if satimdurum == 1 {
                            
                            cell.label.alpha = 1
                            cell.label.layer.borderColor = UIColor.redColor().CGColor
                            cell.contentView.backgroundColor = UIColor.redColor()
                            cell.label.text = myStringArrc[1]
                            
                        }else{
                            
                            
                            
                            
                            if myStringArrc[1] == "NULL"  {
                                cell.label.alpha = 0
                                cell.label.backgroundColor = UIColor.clearColor()
                                cell.label.layer.borderColor = UIColor.clearColor().CGColor
                                cell.label.frame.size.width = 0
                                cell.label.frame.size.height = 0
                                cell.contentView.backgroundColor = UIColor.clearColor()
                            }else{
                                cell.label.text = myStringArrc[1]
                                cell.label.alpha = 1
                                cell.label.frame.size.width = 40
                                cell.label.frame.size.height = 40
                                let color = koltuksiraid.contains(myStringc) ? UIColor(red: 62/256, green: 211/256, blue: 238/256, alpha: 1) : UIColor.greenColor()
                                cell.contentView.backgroundColor = color //Or put orange color as per your logic based on myStringArrc
                            }
                        }
                    }
                }else{
                    cell.label.alpha = 0
                    cell.label.layer.borderColor = UIColor.clearColor().CGColor
                    cell.label.frame.size.width = 0
                    cell.label.frame.size.height = 0
                    cell.contentView.backgroundColor = UIColor.clearColor()
                    cell.alpha = 0
                }
                
            }
        }
        
        cell.label.backgroundColor = UIColor.clearColor()
        
        return cell
    }
}

// MARK: UICollectionViewDelegate
extension CustomCollectionViewController {
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath cellForItemAtIndexPath: NSIndexPath) {
        // You must call super to animate selection
        
        if cellForItemAtIndexPath.item == 0 {
            print(items[cellForItemAtIndexPath.section].base)
            
        } else {
            
            let clickeditem = items[cellForItemAtIndexPath.section].services[cellForItemAtIndexPath.item - 1]
            
            
            
            if let myStringc: String = items[cellForItemAtIndexPath.section].services[cellForItemAtIndexPath.item - 1] {
                var myStringArrc = myStringc.componentsSeparatedByString("*")
                
                
                let satimdurum:Int = Int(myStringArrc[3])!
                let sirano:Int = Int(myStringArrc[0])!
                
                
                
                if sirano == 1 || sirano == 2 {
                    
                    if sirano == 2 {
                        
                        
                        
                        if satimdurum == 0 {
                            
                            
                            if koltuksiraid.contains(clickeditem) {
                                
                                if let index = koltuksiraid.indexOf(clickeditem) {
                                    koltuksiraid.removeAtIndex(index)
                                }
                                
                                
                                let selectedCell:UICollectionViewCell = collectionView.cellForItemAtIndexPath(cellForItemAtIndexPath)!
                                selectedCell.contentView.backgroundColor = UIColor.orangeColor()
                                
                                
                            }else{
                                
                                koltuksiraid.append(clickeditem)
                                
                                let selectedCell:UICollectionViewCell = collectionView.cellForItemAtIndexPath(cellForItemAtIndexPath)!
                                selectedCell.contentView.backgroundColor = UIColor(red: 62/256, green: 211/256, blue: 238/256, alpha: 1)
                                
                                
                            }
                            
                        }else{
                            
                            
                        }
                        
                        
                    }else{
                        
                        
                        if satimdurum == 0 {
                            
                            
                            
                            if koltuksiraid.contains(clickeditem) {
                                
                                if let index = koltuksiraid.indexOf(clickeditem) {
                                    koltuksiraid.removeAtIndex(index)
                                }
                                
                                
                                let selectedCell:UICollectionViewCell = collectionView.cellForItemAtIndexPath(cellForItemAtIndexPath)!
                                selectedCell.contentView.backgroundColor = UIColor.greenColor()
                                
                                
                            }else{
                                
                                koltuksiraid.append(clickeditem)
                                
                                let selectedCell:UICollectionViewCell = collectionView.cellForItemAtIndexPath(cellForItemAtIndexPath)!
                                selectedCell.contentView.backgroundColor = UIColor(red: 62/256, green: 211/256, blue: 238/256, alpha: 1)
                                
                                
                            }
                        }else{
                            
                            
                        }
                        
                        
                    }
                }
                
            }
        }
        print(koltuksiraid)
        
        
        
    }
    
    
    
    
    
}

