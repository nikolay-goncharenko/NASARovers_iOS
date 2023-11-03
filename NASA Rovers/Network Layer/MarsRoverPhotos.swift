//
//  MarsRoverPhotos.swift
//  NASA Rovers
//
//  Created by Nikolay Goncharenko on 29.10.2023.
//

import Foundation
import RealmSwift

struct MarsRoverPhotos: Codable {
    let photos: [Photos]
}

struct Photos: Codable {
    let id, sol: Int
    let camera: Camera
    let imgSrc, earthDate: String
    let rover: Rover
    
    enum CodingKeys: String, CodingKey {
        case id, sol, camera
        case imgSrc = "img_src"
        case earthDate = "earth_date"
        case rover
    }
}

struct Camera: Codable {
    let id: Int
    let name: String
    let roverId: Int
    let fullName: String
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case roverId = "rover_id"
        case fullName = "full_name"
    }
}

struct Rover: Codable {
    let id: Int
    let name, landingDate, launchDate, status: String
    let maxSol: Int
    let maxDate: String
    let totalPhotos: Int
    let cameras: [RoverCameras]
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case landingDate = "landing_date"
        case launchDate = "launch_date"
        case status
        case maxSol = "max_sol"
        case maxDate = "max_date"
        case totalPhotos = "total_photos"
        case cameras
    }
}

//struct RoverCameras: Codable {
//    let name, fullName: String
//
//    enum CodingKeys: String, CodingKey {
//        case name
//        case fullName = "full_name"
//    }
//}

class RoverCameras: Object, Codable {
    @Persisted var name: String
    @Persisted var fullName: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case fullName = "full_name"
    }
}
