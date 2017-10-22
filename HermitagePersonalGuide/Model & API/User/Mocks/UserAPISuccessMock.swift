//
//  UserAPISuccessMock.swift
//  HermitagePersonalGuide
//
//  Created by Ostrenkiy on 21.10.2017.
//  Copyright © 2017 Ostrenkiy. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

class UserAPISuccessMock: UserAPI {
    @discardableResult override func create(user userId: Int, token: String, completion: @escaping ((Error?, UserData?) -> Void)) -> Request? {
        let responseJSON : JSON = [
            "id": 1,
            "avatarURL": "https://pp.userapi.com/c604819/v604819621/42ed2/a7FNRQgFzVw.jpg",
            "interests": "Программирование, Живопись, Мемы",
            "name": "Александр Карпов"
        ]
        completion(nil, UserData(json: responseJSON))
        return nil
    }
}
