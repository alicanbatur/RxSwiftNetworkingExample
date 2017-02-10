//
//  Model.swift
//  RxSwiftExample3
//
//  Created by Ali Can Batur on 10/02/17.
//  Copyright © 2017 alikooo. All rights reserved.
//

import Foundation
import Mapper

struct Country: Mappable {

    let name: String
    let capital: String
    let population: Int
    
    init(map: Mapper) throws {
        try name = map.from("name")
        try capital = map.from("capital")
        try population = map.from("population")
    }
    
}
