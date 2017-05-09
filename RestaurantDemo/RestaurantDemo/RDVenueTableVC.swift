//
//  RDVenueTableVC.swift
//  RestaurantDemo
//
//  Created by Abhishek Thapliyal on 2/16/17.
//  Copyright © 2017 Abhishek Thapliyal. All rights reserved.
//

import UIKit
import SDWebImage
import QuadratTouch
import CoreLocation

class RDVenueTableVC: UITableViewController, RDVenueCellDelegate {

    let reusableCellId = "RDVenueCell" as String
    var venueList : NSMutableArray?
    
    var session : Session!
    var location: CLLocation!
    
    //============================================================================================================================
    // VC : LIFE CYCLE
    //============================================================================================================================
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func searchButtonAction(_ sender: Any) {
        
        let alertController = UIAlertController.init(title: "Write Place...", message: nil, preferredStyle: UIAlertControllerStyle.alert)
        
        alertController.addTextField { (txtField) in
            txtField.placeholder = "Add Place here..."
        }
        
        
        let cancel = UIAlertAction.init(title: "Cancel", style: UIAlertActionStyle.destructive, handler: nil)
        
        let search = UIAlertAction.init(title: "Search", style: UIAlertActionStyle.default) { (alertAction) in
            
            let txtField = alertController.textFields?.first
            
            if (!((txtField?.text?.isEmpty)!)) {
                self.searchPlaces(param: (txtField?.text)!)
            }
        }
        
        alertController.addAction(search)
        alertController.addAction(cancel)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    var venues: [JSONParameters]!
    
    func searchPlaces(param text: String) {
        
        var parameters = [Parameter.query:text]
        parameters += self.location.parameters()
        parameters += [Parameter.radius: "2000"]
        parameters += [Parameter.limit: "50"]
        let searchTask = session.venues.search(parameters) {
            (result) -> Void in
            if let response = result.response {
                self.venues = response["venues"] as! [JSONParameters]?
                
//                DispatchQueue.main.async {
                    for dictObject in self.venues  {
                        
                        let restaurantObj = RDRestaurant(dictionary: dictObject)
                        print("PLACE NAME \(restaurantObj.name)!")
                    }
//                }
            }
        }
        searchTask.start()
    }
    
    //============================================================================================================================
    //  // MARK: - Table view data source
    //============================================================================================================================
   
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        print("ARRAY_COUNT_TVC \((self.venueList?.count)!)")
        return (self.venueList?.count)!
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: self.reusableCellId) as! RDVenueCell
        
        let restaurant = self.venueList?.object(at: indexPath.row) as! RDRestaurant
        
        cell.iconImgView.image = UIImage(named: "restaurant_default_100.png")
        if (restaurant.iconImgUrl != nil) {
    
            let imageURL = NSURL(string : restaurant.iconImgUrl as! String)
            cell.iconImgView.sd_setImage(with: imageURL as URL!, placeholderImage: UIImage(named: "restaurant_default_100.png"))
        }
        cell.nameLabel.text = restaurant.name! as String

        let textString = NSString(format: "%@\n%@", (restaurant.address != nil ? restaurant.address! : ""),
                                  (restaurant.crossStreet != nil ? restaurant.crossStreet! : "")) as String
        
        cell.streetAddLabel.text = textString
        
        if (restaurant.likeDislike! == 0) {
            cell.likeDislikeButton.setImage(UIImage(named: "like_default.png"), for: .normal)
        }
        else if (restaurant.likeDislike! > 0) {
            cell.likeDislikeButton.setImage(UIImage(named: "thumb_like.png"), for: .normal)
        }
        else {
            cell.likeDislikeButton.setImage(UIImage(named: "thumb_dislike.png"), for: .normal)
        }
        
        cell.backgroundColor = UIColor.white
        if (indexPath.row % 2 != 0) {
            cell.backgroundColor = UIColor(red:180.0/255, green:100.0/255, blue:100.0/255, alpha:0.1)
        }
       
        cell.tag = indexPath.row
        cell.delegate = self
        
        return cell
    }
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let restaurant = self.venueList?.object(at: indexPath.row) as! RDRestaurant
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let detailVC = storyBoard.instantiateViewController(withIdentifier: "RDVenueDetailVC") as! RDVenueDetailVC
        detailVC.restaurant = restaurant
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    //============================================================================================================================
    // MARK: - TABLE CUSTOM CELL : CUSTOM DELEGATE
    //============================================================================================================================
    
    internal func tableCell(cell: RDVenueCell) {
        
        let indexPath : IndexPath = self.tableView.indexPath(for: cell)!
        let restaurant = self.venueList?.object(at: indexPath.row) as! RDRestaurant
        
        if (restaurant.likeDislike! == 0) {
            cell.likeDislikeButton.setImage(UIImage(named: "thumb_like.png"), for: .normal)
            restaurant.likeDislike = SHORT_FEEDBACK.LIKE.rawValue
        }
        else if (restaurant.likeDislike! > 0) {
            cell.likeDislikeButton.setImage(UIImage(named: "thumb_dislike.png"), for: .normal)
            restaurant.likeDislike = SHORT_FEEDBACK.DISLIKE.rawValue
        }
        else {
            cell.likeDislikeButton.setImage(UIImage(named: "like_default.png"), for: .normal)
            restaurant.likeDislike = SHORT_FEEDBACK.DEFAULT.rawValue
        }
    }
    
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
