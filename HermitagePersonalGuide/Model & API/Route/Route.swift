//
//  Route.swift
//  HermitagePersonalGuide
//
//  Created by Ostrenkiy on 21.10.2017.
//  Copyright © 2017 Ostrenkiy. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Route {
    var halls: [Int]
    init(json: JSON) {
        halls = json["route"].arrayObject as! [Int]
    }
}
