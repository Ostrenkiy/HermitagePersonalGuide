//
//  UserAPI.swift
//  HermitagePersonalGuide
//
//  Created by Ostrenkiy on 21.10.2017.
//  Copyright © 2017 Ostrenkiy. All rights reserved.
//

import Foundation
import Alamofire
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

class UserAPI {
    let name = "user"
    @discardableResult func create(user userId: Int, token: String, completion: @escaping ((Error?, UserData?)->Void)) -> Request {
        let params: Parameters = [
            "id": userId,
            "token": token
        ]
        return Alamofire.request("\(APIConfig.urlString)/\(name)", method: .post, parameters: params).validate().responseSwiftyJSON({
            response in
            
            switch response.result {
                
            case .failure(let error):
                completion(error, nil)
                
            case .success(let json):
                completion(nil, UserData(json: json))
            }
        })
    }

}
