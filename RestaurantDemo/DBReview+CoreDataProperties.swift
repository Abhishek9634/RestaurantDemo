//
//  DBReview+CoreDataProperties.swift
//  RestaurantDemo
//
//  Created by Abhishek Thapliyal on 2/18/17.
//  Copyright © 2017 Abhishek Thapliyal. All rights reserved.
//

import Foundation
import CoreData


extension DBReview {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DBReview> {
        return NSFetchRequest<DBReview>(entityName: "DBReview");
    }

    @NSManaged public var id: String?
    @NSManaged public var time: Int64
    @NSManaged public var review: String?

}
