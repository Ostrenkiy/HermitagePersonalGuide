//
//  UserData.swift
//  HermitagePersonalGuide
//
//  Created by Ostrenkiy on 21.10.2017.
//  Copyright © 2017 Ostrenkiy. All rights reserved.
//

import Foundation
import SwiftyJSON

struct UserData {
    var id: Int
    var avatarURL: String
    var interests: String
    
    init(json: JSON) {
        id = json["id"].intValue
        avatarURL = json["avatarURL"].stringValue
        interests = json["interests"].stringValue
    }
}

