//
//  ViewController.swift
//  RestaurantDemo
//
//  Created by Abhishek Thapliyal on 2/13/17.
//  Copyright © 2017 Abhishek Thapliyal. All rights reserved.
//

import UIKit
import QuadratTouch
import CoreLocation
import Foundation
import MapKit

typealias JSONParameters = [String: AnyObject]

class ViewController: UIViewController {

    var session: Session!
    var location: CLLocation!
    var venues: [JSONParameters]!
    let distanceFormatter = MKDistanceFormatter()
    var currentTask: Task?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
    
        var parameters = [Parameter.query:"Burgers"]
        parameters += self.location.parameters()
        let searchTask = session.venues.search(parameters) {
            (result) -> Void in
            if let response = result.response {
                self.venues = response["venues"] as! [JSONParameters]?
            }
        }
        searchTask.start()
        
    }

}

