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
            "avatarURL": "https://pp.userapi.com/c836333/v836333001/31189/8To0r3d-6iQ.jpg",
            "interests": "Безопасность, живопись, двач",
            "name": "Николай Дуров"
        ]
        completion(nil, UserData(json: responseJSON))
        return nil
    }
}
