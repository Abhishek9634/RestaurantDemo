//
//  RDLocationManager.swift
//  RestaurantDemo
//
//  Created by Abhishek Thapliyal on 2/14/17.
//  Copyright © 2017 Abhishek Thapliyal. All rights reserved.
//

import UIKit
import CoreLocation
import QuadratTouch
import MapKit

class RDLocationManager: UIViewController, CLLocationManagerDelegate {

    var locationManager : CLLocationManager!
    var session : Session!
//    var viewObject : ViewController!
    
//    var session: Session!
    var location: CLLocation!
    var venues: [JSONParameters]!
    let distanceFormatter = MKDistanceFormatter()
    var currentTask: Task?
    
    
    @IBOutlet weak var loading: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.session = Session.sharedSession()
        self.session.logger = ConsoleLogger()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
//        self.viewObject = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as! ViewController
//        
//        self.viewObject.session = self.session
        
        self.locationManager = CLLocationManager()
        self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        self.locationManager.delegate = self
        let status = CLLocationManager.authorizationStatus()
        if status == .notDetermined {
            self.locationManager.requestWhenInUseAuthorization()
        } else if status == CLAuthorizationStatus.authorizedWhenInUse
            || status == CLAuthorizationStatus.authorizedAlways {
            self.locationManager.startUpdatingLocation()
        } else {
            showNoPermissionsAlert()
        }
        
        self.loading.startAnimating()
    }
    
    
    @IBAction func OpenListAction(_ sender: Any) {
        
//        self.present(self.viewObject, animated: true, completion: nil)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .denied || status == .restricted {
            showNoPermissionsAlert()
        } else {
            self.locationManager.startUpdatingLocation()
        }
        self.loading.stopAnimating()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // Process error.
        // kCLErrorDomain. Not localized.
        print("ERROR_IN_LOCATION : \(error as NSError)")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let newLocation = locations.first {
//            self.viewObject.location = newLocation
            self.location = newLocation
            self.locationManager.stopUpdatingLocation()
            self.setLocationForRequest()
        }
    }
    
    func showNoPermissionsAlert() {
        let alertController = UIAlertController(title: "No permission",
                                                message: "In order to work, app needs your location", preferredStyle: .alert)
        let openSettings = UIAlertAction(title: "Open settings", style: .default, handler: {
            (action) -> Void in
            let URL = Foundation.URL(string: UIApplicationOpenSettingsURLString)            
            UIApplication.shared.open(URL!, options: [:], completionHandler: { (success) in
                print("Open : \(success)")
            })
            
            self.dismiss(animated: true, completion: nil)
        })
        alertController.addAction(openSettings)
        present(alertController, animated: true, completion: nil)
    }
    
    func setLocationForRequest() {
        
        var parameters = [Parameter.query:"Restaurants"]
        parameters += self.location.parameters()
        parameters += [Parameter.radius: "2000"]
        parameters += [Parameter.limit: "50"]
        let searchTask = session.venues.search(parameters) {
            (result) -> Void in
            if let response = result.response {
                self.venues = response["venues"] as! [JSONParameters]?
                
                OperationQueue.main.addOperation {
                    let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
                    let navigationVC = storyBoard.instantiateViewController(withIdentifier: "RDVenueNavigationVC") as! UINavigationController
                    
                    let viewcontroller = (navigationVC.viewControllers as [UIViewController])[0] as! RDVenueTableVC
                    viewcontroller.venueList = NSMutableArray()
                    for dictObject in self.venues  {
                        
                        let restaurantObj = RDRestaurant(dictionary: dictObject)
                        viewcontroller.venueList?.add(restaurantObj)
                    }
                    print("ARRAY_COUNT \(viewcontroller.venueList?.count)!")
                    self.present(navigationVC, animated: true, completion: nil)
                }
                
            }
        }
        searchTask.start()
    }
}

extension CLLocation {
    func parameters() -> Parameters {
        let ll      = "\(self.coordinate.latitude),\(self.coordinate.longitude)"
        let llAcc   = "\(self.horizontalAccuracy)"
        let alt     = "\(self.altitude)"
        let altAcc  = "\(self.verticalAccuracy)"
        let parameters = [
            Parameter.ll:ll,
            Parameter.llAcc:llAcc,
            Parameter.alt:alt,
            Parameter.altAcc:altAcc
        ]
        return parameters
    }
}
