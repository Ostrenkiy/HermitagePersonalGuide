//
//  Pictures.swift
//  HermitagePersonalGuide
//
//  Created by Ostrenkiy on 22.10.2017.
//  Copyright © 2017 Ostrenkiy. All rights reserved.
//

import Foundation
import SwiftyJSON

class Pictures {
    private static var picturesJSONString: String {
        let path = Bundle.main.bundlePath
        let scriptsPlistPath = "\(path)/Pictures.plist"
        let plistData = NSDictionary(contentsOfFile: scriptsPlistPath)!
        return plistData["pictures"] as! String
    }
    
    private static func getJSON() -> JSON {
        return JSON(parseJSON: picturesJSONString)
    }
    
    static func getPictures() -> [Picture] {
        var results = [Picture]()
        let json = getJSON()
        results += json.arrayValue.map({Picture(json: $0)})
        return results
    }
    
    static func getPictures(hall: Int, pictures: [Picture]) -> [Picture] {
        var res: [Picture] = []
        for picture in pictures {
            if picture.hallID == hall {
                res += [picture]
            }
        }
        return res
    }
}
