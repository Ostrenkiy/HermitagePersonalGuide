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
    var id: Int?
    var hallID: Int?
    var rubric: String?
    var title: String?
    var author: String?
    var text: String?
    var meta: String?
    var imageURL: URL?
    
    init(json: JSON) {
        id = json["id"].int
        hallID = json["hall"].int
        rubric = json["rubric"].string
        title = json["title_ru"].string
        author = json["author_ru"].string
        text = json["text_ru"].string
        meta = json["meta_ru"].string
        if let imageUrlString = json["image_url"].string {
            imageURL = URL(string: imageUrlString)
        }
    }
}
