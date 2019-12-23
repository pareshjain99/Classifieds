//
//  ClassifiedDataModel.swift
//  DubizzleClassified
//
//  Created by PareshJain on 12/20/19.
//  Copyright © 2019 dubizzle. All rights reserved.
//

import Foundation

@objcMembers class ClassifiedDataModel: NSObject {
     let created_at: String?
     let price: String?
     let name: String?
     let image_urls: String?
     let image_urls_thumbnails: String?
    
    init(model: ClassifiedItem) {
        self.created_at = model.created_at.toDate()?.getElapsedInterval()
        self.price = model.price
        self.name = model.name
        self.image_urls = model.image_urls[0]
        self.image_urls_thumbnails = model.image_urls_thumbnails[0]
    }
}

