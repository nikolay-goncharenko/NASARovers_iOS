//
//  HomeModel.swift
//  NASA Rovers
//
//  Created by Nikolay Goncharenko on 30.10.2023.
//

import RealmSwift
import UIKit.UIImage

//struct HomeModel {
//    let roverName: String
//    let cameraName: String
//    let cameraFullName: String
//    let image: UIImage
//    let earthDate: String
//}

class HomeModel: Object {
    @Persisted var roverName: String
    @Persisted var cameraName: String
    @Persisted var cameraFullName: String
    @Persisted var image: Data
    @Persisted var earthDate: String
    
    convenience init(roverName: String, cameraName: String, cameraFullName: String, image: Data, earthDate: String) {
        self.init()
        self.roverName = roverName
        self.cameraName = cameraName
        self.cameraFullName = cameraFullName
        self.image = image
        self.earthDate = earthDate
    }
}
