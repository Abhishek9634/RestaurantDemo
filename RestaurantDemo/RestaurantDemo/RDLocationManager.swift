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

class RDLocationManager: UIViewController, CLLocationManagerDelegate {

    var locationManager : CLLocationManager!
    var session : Session!
    var viewObject : ViewController!
    

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
        
        self.viewObject = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as! ViewController
        
        self.viewObject.session = self.session
        
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
    }
    
    
    @IBAction func OpenListAction(_ sender: Any) {
        
        self.present(self.viewObject, animated: true, completion: nil)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .denied || status == .restricted {
            showNoPermissionsAlert()
        } else {
            self.locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // Process error.
        // kCLErrorDomain. Not localized.
        print("ERROR_IN_LOCATION : \(error as NSError)")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let newLocation = locations.first {
            self.viewObject.location = newLocation
            self.locationManager.stopUpdatingLocation()
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
