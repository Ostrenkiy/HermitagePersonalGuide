//
//  iBeaconSerivce.swift
//  HermitagePersonalGuide
//
//  Created by Андрей on 21.10.2017.
//  Copyright © 2017 Ostrenkiy. All rights reserved.
//

import UIKit
import CoreLocation

class BeaconSerivce: NSObject {
    let locationManager = CLLocationManager()
    var beaconHallDictionary:[String:Int] = [:]
    
    private override init(){
        super.init()
        locationManager.delegate = self
        
        let region = CLBeaconRegion(
            //Здесь должны быть UUID перепрошитых биконов
            proximityUUID: UUID(uuidString: "00000000-0000-0000-0000-000000000000")!,
            identifier: "identifier"
        )
        
        //Для 10 зала вот такой регион
        beaconHallDictionary[region.proximityUUID.uuidString] = 10
        //Сюда вот нужно дописать другие регионы
        locationManager.startRangingBeacons(in: region);
    }
}

extension BeaconSerivce:CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager,
                         didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        let beacon = beacons.last
        
        if beacons.count > 0 {
            if let uuid = beacon?.proximityUUID.uuidString, let value = beaconHallDictionary[uuid] {
                //тут отправляем запрос
            }
        }
    }
}
