//
//  Product.swift
//  TestTask
//
//  Created by Ацамаз on 31/01/2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import Foundation

class Product {
    
    var name: String
    var tagline: String
    
    var upvotes: Int

    var thumbnailUrl: URL
    var screenshotUrl: URL
    var link: URL
    
    
    init(name: String,
         tagline: String,
         upvotes: Int,
         thumbnailUrl: URL,
         screenshotUrl: URL,
         link: URL)
    {
        
        self.name = name
        self.tagline = tagline
        self.upvotes = upvotes
        self.thumbnailUrl = thumbnailUrl
        self.screenshotUrl = screenshotUrl
        self.link = link
        
    }
    
    
    
}
