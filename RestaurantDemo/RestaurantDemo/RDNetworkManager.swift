//
//  RDNetworkManager.swift
//  RestaurantDemo
//
//  Created by Abhishek Thapliyal on 2/14/17.
//  Copyright © 2017 Abhishek Thapliyal. All rights reserved.
//

import UIKit

class RDNetworkManager: NSObject {

    public var responseDict : NSDictionary?
    public var venueList : NSArray?
    public var restaurantList : NSMutableArray?
    
    //====================================================================================================================================
    // GET NEAR VENUE METHOD
    //====================================================================================================================================
    
    public func getNearVenues(urlString:NSString, completion : @escaping (_ articleArray:NSArray, _ error:NSError?) -> Void) {
        
        let request : NSMutableURLRequest = RDHTTPRequest.getServerRequest(urlString: urlString as String, paramString: nil)
        RDHTTPResponse.responseWithRequest(request: request, requestTitle: "FETCH_RESTAURANTS", completion: { (json, error) in
            
            print("ERROR :: \(error?.localizedDescription)")
            self.restaurantList = NSMutableArray()
            if (error == nil)
            {
                let dictionary : [String:Any] = json as! [String : Any]
                self.responseDict = NSDictionary(dictionary: dictionary["response"] as! NSDictionary)
                self.venueList = NSArray(array: self.responseDict?["venues"] as! NSArray)
                
                for dictObject in self.venueList as! [[String:Any]] {
                
                    let restaurantObj = RDRestaurant(dictionary: dictObject)
                    self.restaurantList?.add(restaurantObj)
                }
                print("COUNT : \((self.restaurantList?.count)!)")
            }
            completion(self.restaurantList!, error)
        })
    }
}
