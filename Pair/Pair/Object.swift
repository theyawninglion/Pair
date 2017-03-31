//
//  Object.swift
//  Pair
//
//  Created by Taylor Phillips on 3/31/17.
//  Copyright © 2017 Taylor Phillips. All rights reserved.
//

import Foundation

class Object {
    
    private let nameKey = "name"
    
    let name: String
    
    init(name: String) {
        self.name = name
    }
    
    init?(dictionary: [String: String]) {
        guard let name = dictionary[nameKey]
            else { return nil }
        self.name = name
        
    }
}
