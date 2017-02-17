//
//  RDVenueDetailVC.swift
//  RestaurantDemo
//
//  Created by Abhishek Thapliyal on 2/16/17.
//  Copyright © 2017 Abhishek Thapliyal. All rights reserved.
//

import UIKit

class RDVenueDetailVC: UITableViewController {

    let reusableCellId = "RDVenueDetailCell" as String
    public var restaurant : RDRestaurant?
    
    @IBOutlet weak var venurIconView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var contactLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("VENUE_ID : \(self.restaurant?.id)")
        let imageURL = NSURL(string : self.restaurant?.iconImgUrl as! String)
        if let data = NSData(contentsOf: imageURL as! URL) {
            self.venurIconView.image = UIImage(data: data as Data)
        }
        
        self.nameLabel.text = self.restaurant?.name! as String?
        
        var address : String = ""
        for str in (self.restaurant?.formattedAddress)! {
            address = address + "\(str) \n"
        }
        
//        self.addressLabel.text = self.restaurant?.formattedAddress?.description
         self.addressLabel.text = address
        
        self.contactLabel.text = self.restaurant?.formattedPhone != nil ? self.restaurant?.formattedPhone! as String? : ""
//      self.contactLabel.text = "12345"
        DispatchQueue.main.async {
            self.venurIconView.layer.cornerRadius = self.venurIconView.frame.size.width/2;
            self.venurIconView.layer.masksToBounds = true
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: self.reusableCellId, for: indexPath) as! RDVenueDetailCell

        // Configure the cell...

        return cell
    }
 
    //============================================================================================================================
    // BUTTON ACTION
    //============================================================================================================================
    
    @IBAction func webPageButtonAction(_ sender: Any) {
    
        print("WEB_LINK : \(self.restaurant?.url)")
        if (self.restaurant?.url == nil) {
            self.showAlert()
            return
        }
        
        let webURL = NSURL(string : self.restaurant?.url as! String)
        UIApplication.shared.open(webURL as! URL, options: [:], completionHandler: nil)
    }
    
    @IBAction func reviewButtonAction(_ sender: Any) {
    
        self.showAlert()
    }
    
    @IBAction func locationButtonAction(_ sender: Any) {
        
        print("LAT_LNG : \(self.restaurant?.lat) && \(self.restaurant?.lng)")
        if (self.restaurant?.lat == nil || self.restaurant?.lng == nil) {
            self.showAlert()
            return
        }
        
        let location = NSString(format : "https://www.google.co.in/maps/@%@,%@,16z", (restaurant?.lat)!, (restaurant?.lng)!)
        let webURL = NSURL(string : location as String)
        UIApplication.shared.open(webURL as! URL, options: [:], completionHandler: nil)
    }
    
    @IBAction func twitterButtonAction(_ sender: Any) {
        
        print("TWIITER : \(self.restaurant?.twitter)")
        if (self.restaurant?.twitter == nil) {
            self.showAlert()
            return
        }
        
        let twitterURL = NSString(format : "https://twitter.com/%@?lang=en",(restaurant?.twitter)!)
        let webURL = NSURL(string : twitterURL as String)
        UIApplication.shared.open(webURL as! URL, options: [:], completionHandler: nil)
    }
    
    @IBAction func fbButtonAction(_ sender: Any) {
     
        print("FACEBOOK : \(self.restaurant?.facebookUsername)")
        if (self.restaurant?.facebookUsername == nil) {
            self.showAlert()
            return
        }
        
        let faceBookURL = NSString(format : "https://www.facebook.com/%@",(restaurant?.facebookUsername)!)
        let webURL = NSURL(string : faceBookURL as String)
        UIApplication.shared.open(webURL as! URL, options: [:], completionHandler: nil)
    }

    func showAlert() {
        let alert = UIAlertController.init(title: "Oops!!!", message: "Not Available", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(defaultAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
