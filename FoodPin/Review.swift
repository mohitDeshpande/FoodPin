//
//  Review.swift
//  FoodPin
//
//  Created by Ajiboye Adedeji A. on 4/23/18.
//  Copyright © 2018 AppCoda. All rights reserved.
//

import Foundation

class Review{
    var id:String = ""
    var rating:Int = 0
    var text:String = ""
    var time_created:String = ""
    var url:String = ""
   
    
    init(id:String,rating:Int,text:String, time_created:String,url:String) {
        self.id = id
        self.rating = rating
        self.text = text
        self.time_created = time_created
        self.url = url
        
    }
}
