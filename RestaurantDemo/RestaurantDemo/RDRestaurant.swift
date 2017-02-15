//
//  RDRestaurant.swift
//  RestaurantDemo
//
//  Created by Abhishek Thapliyal on 2/14/17.
//  Copyright © 2017 Abhishek Thapliyal. All rights reserved.
//

import UIKit

class RDRestaurant: NSObject {

    public var id : NSString?
    public var name : NSString?
    
    public var contact : NSDictionary?
    public var phone : NSString?
    public var formattedPhone : NSString?
    public var twitter : NSString?
    
    public var location : NSDictionary?
    public var address : NSString?
    public var crossStreet : NSString?
    public var lat : NSNumber?
    public var lng : NSNumber?
    
    public var labeledLatLngs : NSArray? // consist dictionary object(s)
    public var l_lat : NSNumber?
    public var l_lng : NSNumber?
    public var l_label : NSString?
    
    public var distance : NSInteger?
    public var postalCode : NSInteger?
    public var cc : NSString?
    public var city : NSString?
    public var state : NSString?
    public var country : NSString?
    public var formattedAddress : NSArray?
    
    public var categories : NSArray?  // consist dictionary object(s)
    public var c_id : NSString?
    public var c_name : NSString?
    public var pluralName : NSString?
    public var shortName : NSString?
    public var icon : NSDictionary?
    public var prefix : NSString?
    public var suffix : NSString?
    public var primary : Bool?
    
    public var verified : Bool?
    
    public var stats : NSDictionary?
    public var checkinsCount : NSInteger?
    public var usersCount : NSInteger?
    public var tipCount : NSInteger?
    
    public var url : NSString?
    public var hasMenu : Bool?
    
    public var menu : NSDictionary?
    public var m_type : NSString?
    public var m_label : NSString?
    public var m_anchor : NSString?
    public var m_icon : NSDictionary?
    public var m_url : NSString?
    public var m_mobileUrl : NSString?
    
    public var allowMenuUrlEdit : Bool?
    public var beenHere : NSDictionary?
    public var lastCheckinExpiredAt : NSInteger?
    
    public var specials : NSDictionary?
    public var count : NSInteger?
    public var items : NSArray?
    
    public var hereNow : NSDictionary?
    public var h_count : NSInteger?
    public var h_summary : NSString?
    public var h_groups : NSArray? // consist dictionary object(s)
    public var g_type : NSString?
    public var g_name : NSString?
    public var g_count : NSInteger?
    public var g_items : NSArray?
    
    public var referralId : NSString?
    public var venueChains : NSArray? // consist dictionary object(s)
    public var v_id : NSString?
    public var hasPerk : Bool?
    
    override init() {
        
    }
    
    /********************************************************
     CUSTOM INTIALIZATION : INIT WITH DICTIONARY
     ********************************************************/
    
    init(dictionary : [String:Any]) {
        super.init()
        self.parseDictionary(dictionary: dictionary)
    }
    
    /********************************************************
     PARSING DICTIONARY : MAPPING DATA TO CLASS PROPERTIES
     ********************************************************/
    
    public func parseDictionary(dictionary : [String:Any]) {
        
        self.id = dictionary["author"] as? NSString
        self.name = dictionary["title"] as? NSString
        self.contact = dictionary["contact"] as? NSDictionary
        self.phone = dictionary["url"] as? NSString
        self.formattedPhone = dictionary["urlToImage"] as? NSString
        self.twitter = dictionary["twitter"] as? NSString
        self.location = dictionary["location"] as? NSDictionary
        
        self.categories = dictionary["categories"] as? NSArray
        
        self.verified = dictionary["categories"] as? Bool
        self.stats = dictionary["stats"] as? NSDictionary
    }
    /*

     
     
     "id": "4afe2d94f964a520872e22e3",
     "name": "The Fish Market Santa Clara",
     "contact": {
     "phone": "4082463474",
     "formattedPhone": "(408) 246-3474",
     "twitter": "thefishmarkets"
     },
     "location": {
     "address": "3775 El Camino Real",
     "crossStreet": "btwn Halford & Helen",
     "lat": {
     "s": 1,
     "e": 1,
     "c": [
     3,
     7,
     3,
     5,
     2,
     6,
     6,
     0,
     2,
     2,
     3,
     8,
     8,
     7,
     6,
     8
     ]
     },
     "lng": {
     "s": -1,
     "e": 2,
     "c": [
     1,
     2,
     2,
     0,
     0,
     0,
     3,
     4,
     4,
     8,
     1,
     1,
     4,
     7,
     6,
     1,
     4
     ]
     },
     "labeledLatLngs": [
     {
     "label": "display",
     "lat": {
     "s": 1,
     "e": 1,
     "c": [
     3,
     7,
     3,
     5,
     2,
     6,
     6,
     0,
     2,
     2,
     3,
     8,
     8,
     7,
     6,
     8
     ]
     },
     "lng": {
     "s": -1,
     "e": 2,
     "c": [
     1,
     2,
     2,
     0,
     0,
     0,
     3,
     4,
     4,
     8,
     1,
     1,
     4,
     7,
     6,
     1,
     4
     ]
     }
     }
     ],
     "distance": 3547,
     "postalCode": "95051",
     "cc": "US",
     "city": "Santa Clara",
     "state": "CA",
     "country": "United States",
     "formattedAddress": [
     "3775 El Camino Real (btwn Halford & Helen)",
     "Santa Clara, CA 95051",
     "United States"
     ]
     },
     "categories": [
     {
     "id": "4bf58dd8d48988d1ce941735",
     "name": "Seafood Restaurant",
     "pluralName": "Seafood Restaurants",
     "shortName": "Seafood",
     "icon": {
     "prefix": "https://ss3.4sqi.net/img/categories_v2/food/seafood_",
     "suffix": ".png"
     },
     "primary": true
     }
     ],
     "verified": true,
     "stats": {
     "checkinsCount": 5319,
     "usersCount": 3018,
     "tipCount": 77
     },
     "url": "http://www.thefishmarket.com",
     "hasMenu": true,
     "menu": {
     "type": "Menu",
     "label": "Menu",
     "anchor": "View Menu",
     "url": "https://foursquare.com/v/the-fish-market-santa-clara/4afe2d94f964a520872e22e3/menu",
     "mobileUrl": "https://foursquare.com/v/4afe2d94f964a520872e22e3/device_menu"
     },
     "allowMenuUrlEdit": true,
     "beenHere": {
     "lastCheckinExpiredAt": 0
     },
     "specials": {
     "count": 0,
     "items": []
     },
     "hereNow": {
     "count": 4,
     "summary": "4 people are here",
     "groups": [
     {
     "type": "others",
     "name": "Other people here",
     "count": 4,
     "items": []
     }
     ]
     },
     "referralId": "v-1487133170",
     "venueChains": [
     {
     "id": "556f3eb3bd6a007c77381f58"
     }
     ],
     "hasPerk": false
     
     
     // sample raw
     
     {"id":"4a3ad2f3f964a52051a01fe3","name":"Faz Restaurants & Catering","contact":{"phone":"4087528000","formattedPhone":"(408) 752-8000","twitter":"fazrestaurant"},"location":{"address":"1108 N Mathilda Ave","lat":37.404692161430596,"lng":-122.0251388714158,"labeledLatLngs":[{"label":"display","lat":37.404692161430596,"lng":-122.0251388714158}],"distance":8073,"postalCode":"94089","cc":"US","city":"Sunnyvale","state":"CA","country":"United States","formattedAddress":["1108 N Mathilda Ave","Sunnyvale, CA 94089","United States"]},"categories":[{"id":"4bf58dd8d48988d1c0941735","name":"Mediterranean Restaurant","pluralName":"Mediterranean Restaurants","shortName":"Mediterranean","icon":{"prefix":"https:\/\/ss3.4sqi.net\/img\/categories_v2\/food\/mediterranean_","suffix":".png"},"primary":true}],"verified":true,"stats":{"checkinsCount":2786,"usersCount":1659,"tipCount":31},"url":"https:\/\/www.facebook.com\/fazrestaurant","hasMenu":true,"menu":{"type":"Menu","label":"Menu","anchor":"View Menu","url":"https:\/\/foursquare.com\/v\/faz-restaurants--catering\/4a3ad2f3f964a52051a01fe3\/menu","mobileUrl":"https:\/\/foursquare.com\/v\/4a3ad2f3f964a52051a01fe3\/device_menu"},"allowMenuUrlEdit":true,"beenHere":{"lastCheckinExpiredAt":0},"specials":{"count":0,"items":[]},"hereNow":{"count":1,"summary":"One other person is here","groups":[{"type":"others","name":"Other people here","count":1,"items":[]}]},"referralId":"v-1487133170","venueChains":[{"id":"556e5cddbd6a82902e29895e"}],"hasPerk":false},
     
     */
    

    
}
