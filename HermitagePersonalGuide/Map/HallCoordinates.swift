//
//  HallCoordinates.swift
//  HermitagePersonalGuide
//
//  Created by Ostrenkiy on 21.10.2017.
//  Copyright © 2017 Ostrenkiy. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Hall {
    var id: Int
    var coordinates: CGPoint
    var floor: Int
    
    init(json: JSON, floor: Int) {
        self.coordinates = CGPoint(x: json["location"]["x"].intValue, y: json["location"]["y"].intValue)
        self.id = json["id"].intValue
        self.floor = floor
    }
}

class HallCoordinates {
    private static var coordinatesJSONString: String {
        let path = Bundle.main.bundlePath
        let scriptsPlistPath = "\(path)/HallCoordinates.plist"
        let plistData = NSDictionary(contentsOfFile: scriptsPlistPath)!
        return plistData["coordinates"] as! String
    }
    
    private static func getJSON() -> JSON {
        return JSON(coordinatesJSONString)
    }
    
    static func getCoordinates() -> [Hall] {
        var results = [Hall]()
        let json = getJSON()
        results += json["floor1"].arrayValue.map({Hall(json: $0, floor: 1)})
        results += json["floor2"].arrayValue.map({Hall(json: $0, floor: 2)})
        results += json["floor3"].arrayValue.map({Hall(json: $0, floor: 3)})
        return results
    }
}
