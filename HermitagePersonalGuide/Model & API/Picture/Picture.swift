//
//  Picture.swift
//  HermitagePersonalGuide
//
//  Created by Ostrenkiy on 21.10.2017.
//  Copyright © 2017 Ostrenkiy. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Picture {
    var id: Int
    var hallID: Int
    var rubric: String
    var title: String
    var author: String
    var text: String
    var meta: String
    var imageURL: URL
    
    init(json: JSON) {
        id = json["id"].intValue
        hallID = json["hallID"].intValue
        rubric = json["rubric"].stringValue
        title = json["title_ru"].stringValue
        author = json["author_ru"].stringValue
        text = json["text_ru"].stringValue
        meta = json["meta_ru"].stringValue
        imageURL = URL(string: json["image_URL"].stringValue)!
    }
}
