//
//  RDDBManager.swift
//  RestaurantDemo
//
//  Created by Abhishek Thapliyal on 2/18/17.
//  Copyright © 2017 Abhishek Thapliyal. All rights reserved.
//

import UIKit
import CoreData

class RDDBManager: NSObject {

    public func insertReview(reviewOb: RDRestaurantReview) {
     
        let context = RDDatabaseManager().persistentContainer.viewContext
        let entityDescription = NSEntityDescription.entity(forEntityName: "DBReview", in: context)
        let newData = NSManagedObject(entity: entityDescription!, insertInto: context)
        
        newData.setValue(reviewOb.id!, forKey: "id")
        newData.setValue(reviewOb.time!, forKey: "time")
        newData.setValue(reviewOb.review!, forKey: "review")
        
        do {
            try newData.managedObjectContext?.save()
        } catch {
            print(error)
        }
    }
    
    public func fetchReviews(id: String) -> NSMutableArray {
    
        let context = RDDatabaseManager().persistentContainer.viewContext
        let entityDescription = NSEntityDescription.entity(forEntityName: "DBReview", in: context)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        let predicate = NSPredicate(format: "id contains[c] %@", id)
        fetchRequest.entity = entityDescription
        fetchRequest.predicate = predicate

        let resultArray = NSMutableArray()
        
        do {            
            let result = try context.fetch(fetchRequest) as! [NSManagedObject]
            
            for reviewOb in result {
            
                if let id = reviewOb.value(forKey: "id") as! NSString?, let reviewText = reviewOb.value(forKey: "review") as! NSString? {
                    print("\n \(id) && \(reviewText)")
                    let reviewObject = RDRestaurantReview()
                    reviewObject.id = id as String
                    reviewObject.time = reviewOb.value(forKey: "time") as! NSNumber?
                    reviewObject.review = reviewText as String
                    resultArray.add(reviewObject)
                }
            }
            
        } catch {
            let fetchError = error as NSError
            print(fetchError)
        }
        return resultArray
    }
}
