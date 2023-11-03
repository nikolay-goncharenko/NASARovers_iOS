//
//  Routes.swift
//  NASA Rovers
//
//  Created by Nikolay Goncharenko on 29.10.2023.
//

import Foundation
import RealmSwift

final class Routes {
    
    static func baseUrl(rover: Rover) -> String {
        let url = "https://api.nasa.gov/mars-photos/api/v1/rovers/%@/photos"
        return String(format: url, arguments: [rover.name])
    }
    
    static func roverUrlParams(page: Int = 1) -> [String: String] {
        let params = [
            URLParams.apiKey.key: URLParams.apiKey.val,
            URLParams.sol.key: URLParams.sol.val,
            URLParams.page.key: "\(page)"
        ]
        return params
    }
    
    static func cameraUrlParams(camera: String, page: Int = 1) -> [String: String] {
        let params = [
            URLParams.apiKey.key: URLParams.apiKey.val,
            URLParams.sol.key: URLParams.sol.val,
            URLParams.camera.key: camera,
            URLParams.page.key: "\(page)"
        ]
        return params
    }
    
    static func dateUrlParams(date: String, page: Int = 1) -> [String: String] {
        let params = [
            URLParams.apiKey.key: URLParams.apiKey.val,
            URLParams.date.key: date,
            URLParams.page.key: "\(page)"
        ]
        return params
    }
}

extension Routes {
    
    enum Rover: Int, CaseIterable, PersistableEnum {
        case curiosity, opportunity, spirit
        
        var name: String {
            return ["curiosity", "opportunity", "spirit"][self.rawValue]
        }
    }
    
    enum URLParams: Int, CaseIterable {
        case apiKey, sol, camera, date, page
        
        var key: String {
            return ["api_key", "sol", "camera", "earth_date", "page"][self.rawValue]
        }
        
        var val: String {
            return ["nifArqPEtSMgjx4v37liBdJ3PtwujRtsF9bae7mS", "1000"][self.rawValue]
        }
    }
}
