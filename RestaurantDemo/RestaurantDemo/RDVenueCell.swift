//
//  RDVenueCell.swift
//  RestaurantDemo
//
//  Created by Abhishek Thapliyal on 2/16/17.
//  Copyright © 2017 Abhishek Thapliyal. All rights reserved.
//

import UIKit

class RDVenueCell: UITableViewCell {

    
    @IBOutlet weak var iconImgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var streetAddLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
