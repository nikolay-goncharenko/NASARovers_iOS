//
//  Adapters.swift
//  NASA Rovers
//
//  Created by Nikolay Goncharenko on 03.11.2023.
//

import Foundation
import RealmSwift

func convertToRealmList(_ cameras: [RoverCameras]) -> List<RoverCameras> {
    let realmList = List<RoverCameras>()
    cameras.forEach { camera in
        realmList.append(camera)
    }
    return realmList
}

func convertFromRealmList(_ realmList: List<RoverCameras>) -> [RoverCameras] {
    var cameras = [RoverCameras]()
    realmList.forEach { camera in
        cameras.append(camera)
    }
    return cameras
}
