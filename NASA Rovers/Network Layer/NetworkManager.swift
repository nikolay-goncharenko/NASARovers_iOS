//
//  NetworkManager.swift
//  NASA Rovers
//
//  Created by Nikolay Goncharenko on 29.10.2023.
//

import Alamofire
import AlamofireImage
import UIKit.UIImage

final class NetworkManager {
    
    static func getAllRoversPhoto(rover: Routes.Rover, page: Int = 1, completion: @escaping (_ model: Photos) -> Void) {
        let url = Routes.baseUrl(rover: rover)
        let params = Routes.roverUrlParams(page: page)
        
        AF.request(url, method: .get, parameters: params).responseDecodable(of: MarsRoverPhotos.self) { response in
            switch response.result {
            case .success(let model):
                model.photos.forEach { item in
                    completion(item)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    static func getAllPhotosByOneCamera(rover: Routes.Rover, camera: String, page: Int = 1, completion: @escaping (_ model: Photos) -> Void) {
        let url = Routes.baseUrl(rover: rover)
        let params = Routes.cameraUrlParams(camera: camera, page: page)
        
        AF.request(url, method: .get, parameters: params).responseDecodable(of: MarsRoverPhotos.self) { response in
            switch response.result {
            case .success(let model):
                model.photos.forEach { completion($0) }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    static func getAllPhotosByDate(rover: Routes.Rover, date: String, page: Int = 1, completion: @escaping (_ model: Photos) -> Void) {
        let url = Routes.baseUrl(rover: rover)
        let params = Routes.dateUrlParams(date: date, page: page)
        
        AF.request(url, method: .get, parameters: params).responseDecodable(of: MarsRoverPhotos.self) { response in
            switch response.result {
            case .success(let model):
                model.photos.forEach { completion($0) }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    static func srcToUIImage(url: String, completion: @escaping (_ image: Data) -> Void) {
        AF.request(url.https).responseImage { response in
            if case .success(let image) = response.result {
                guard let imageData = image.jpegData(compressionQuality: 1.0) else {
                    return
                }
                completion(imageData)
            }
        }
    }
}
