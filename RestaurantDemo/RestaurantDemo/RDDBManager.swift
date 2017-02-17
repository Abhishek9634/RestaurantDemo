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
    
    public func fetchReviews(id: String) {
    
        let context = RDDatabaseManager().persistentContainer.viewContext
        let entityDescription = NSEntityDescription.entity(forEntityName: "DBReview", in: context)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        let predicate = NSPredicate(format: "id contains[c] %@", id)
        fetchRequest.entity = entityDescription
        fetchRequest.predicate = predicate

        do {
//            let result = try context.fetch(fetchRequest)
//            let review = result[0] as! NSManagedObject
//            print(result) // for single result
            
            let result = try context.fetch(fetchRequest) as! [NSManagedObject]
            for reviewOb in result {
            
                if let id = reviewOb.value(forKey: "id"), let reviewText = reviewOb.value(forKey: "review") {
                    print("\n \(id) && \(reviewText)")
                }
            }
            
        } catch {
            let fetchError = error as NSError
            print(fetchError)
        }
    }
}
