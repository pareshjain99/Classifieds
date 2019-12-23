//
//  ClassifiedItem.swift
//  DubizzleClassified
//
//  Created by PareshJain on 12/20/19.
//  Copyright © 2019 dubizzle. All rights reserved.
//

struct ClassifiedItem: Decodable {
    let created_at: String
    let price: String
    let name: String
    let uid: String
    let image_ids: [String]
    let image_urls: [String]
    let image_urls_thumbnails: [String]

    enum CodingKeys: String, CodingKey {
        case created_at = "created_at"
        case price = "price"
        case name = "name"
        case uid = "uid"
        case image_ids = "image_ids"
        case image_urls = "image_urls"
        case image_urls_thumbnails = "image_urls_thumbnails"
    }
}

struct ClassifiedItemList: Decodable {
    let results: [ClassifiedItem]
    
    enum CodingKeys: String, CodingKey {
        case results = "results"
    }
}
