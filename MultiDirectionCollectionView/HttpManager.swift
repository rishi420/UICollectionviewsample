//
//  HttpManager.swift
//  MultiDirectionCollectionView
//
//  Created by Warif Akhand Rishi on 8/9/16.
//  Copyright © 2016 Credera. All rights reserved.
//

import Foundation

class HttpManager {
    
    class func getRequest(url: String, parameter: Dictionary <String, AnyObject>?, completionHandler: (responseData: [Item]?, errorMessage: String?) -> ()) {

        guard let url = NSURL(string: url) else {
            completionHandler(responseData: .None, errorMessage: "URL string was malformed")
            return
        }
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in
            
            guard error == nil else {
                completionHandler(responseData: .None, errorMessage: error?.localizedDescription)
                return
            }
            
            guard let data = data else {
                completionHandler(responseData: .None, errorMessage: "Empty Data")
                return
            }
            
            guard let jsonSerialization =  try? NSJSONSerialization.JSONObjectWithData(data, options:[]), jsonArray = jsonSerialization as? NSArray else {
                completionHandler(responseData: .None, errorMessage: "NSJSONSerialization error")
                return
            }
            
             var items = [Item]()
            
            jsonArray.forEach({ (eachItem) -> () in
                guard let dic = eachItem as? NSDictionary else { return }
                guard let service = dic["Seats"] as? String, base = dic["Base"] as? String else {
                    completionHandler(responseData: .None, errorMessage: "JSON structure missmatch")
                    return
                }
                
                let services = service.componentsSeparatedByString(",")
                let item = Item(base: base, services: services)
                items.append(item)
            })
            
            completionHandler(responseData: items, errorMessage: .None)
        }
        
        task.resume()
    }
}