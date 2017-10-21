//
//  RouteAPIPaginatedMock.swift
//  HermitagePersonalGuide
//
//  Created by Ostrenkiy on 21.10.2017.
//  Copyright © 2017 Ostrenkiy. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class RouteAPIMock: RouteAPI {
    override func retrieve(user userId: Int, location: Int, wantOut: Bool, completion: @escaping ((Error?, Route?) -> Void)) -> Request? {
        let responseJSON : JSON = [
            "route": [192, 191, 190, 189, 187, 186, 185, 184, 183, 182, 181, 180, 179, 178, 177, 176, 175, 174, 173, 172, 171, 170, 169, 168, 167, 166, 165, 164, 163, 162, 161, 160, 159, 158, 157, 156, 153, 151, 193, 400, 398, 397]
        ]
        completion(nil, Route(json: responseJSON))

        return nil
    }
}
