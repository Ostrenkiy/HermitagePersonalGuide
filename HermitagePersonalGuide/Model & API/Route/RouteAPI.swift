//
//  RouteAPI.swift
//  HermitagePersonalGuide
//
//  Created by Ostrenkiy on 21.10.2017.
//  Copyright © 2017 Ostrenkiy. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class RouteAPI {
    let name = "route"
    @discardableResult func retrieve(user userId: Int, location: Int, wantOut: Bool, completion: @escaping ((Error?, Route?)->Void)) -> Request? {
        
        let params: Parameters = [
            "id": userId,
            "location": location,
            "wantOut": wantOut
        ]
        
        return Alamofire.request("\(APIConfig.urlString)/\(name)", method: .get, parameters: params).validate().responseSwiftyJSON({
            response in
            
            switch response.result {
                
            case .failure(let error):
                completion(error, nil)
                
            case .success(let json):
                completion(nil, Route(json: json))
            }
        })
    }
}
