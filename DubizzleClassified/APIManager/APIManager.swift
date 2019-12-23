//
//  APIManager.swift
//  DubizzleClassified
//
//  Created by PareshJain on 12/20/19.
//  Copyright © 2019 dubizzle. All rights reserved.
//

import Foundation
import UIKit

public class APIManager {
    
    static func fetchData(completion:@escaping ([ClassifiedItem]) -> Void) {
        if let url = URL(string: Constants.jsonURL) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    do {
                        let res = try JSONDecoder().decode(ClassifiedItemList.self, from: data)
                        completion(res.results)
                    } catch let error {
                        print(error)
                    }
                }
            }.resume()
        }
    }
}
