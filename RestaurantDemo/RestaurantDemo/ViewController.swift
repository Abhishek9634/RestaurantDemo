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
    
        var parameters = [Parameter.query:"Restaurants"]
        parameters += self.location.parameters()
        let searchTask = session.venues.search(parameters) {
            (result) -> Void in
            if let response = result.response {
                self.venues = response["venues"] as! [JSONParameters]?
            }
        }
        searchTask.start()
        
    }

    /* JUST FOR TESTING HARD CODED CHANGE BEFORE SUBMITTING  */
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let requestManager = RDNetworkManager()
        let URL = "https://api.foursquare.com/v2/venues/search?client_secret=VFA414TABVTOTQPIAOEKEQSMW4GOKQTLY4BKKB4GM0W5FHUS&llAcc=5.0&ll=37.33233141,-122.0312186&client_id=PDZY43TGZKAVF3WA1T4QG1BN2BYJJ44YKLZPGZF4UGFBTJKE&alt=0.0&altAcc=-1.0&v=20140503&query=Restaurants&locale=en"
        
        requestManager.getNearVenues(urlString: URL as NSString) { (array, error) in
            
        }
        
    }
    
}

