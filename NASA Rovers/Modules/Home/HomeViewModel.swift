//
//  HomeViewModel.swift
//  NASA Rovers
//
//  Created by Nikolay Goncharenko on 26.10.2023.
//

import UIKit
import RealmSwift
import SwiftMessages

class HomeViewModel {
    unowned var view: HomeViewController
    
    let realm = try! Realm()
    var storage = TempStorage()
    lazy var realmStorage = realm.objects(TempStorage.self)
    
    internal var homeModel = [HomeModel]()
    
    internal var page = 1
    
    internal var collectionViewReloadData: (() -> Void)?
    
    internal var roverDidChange: ((Routes.Rover) -> Void)?
    
    init(view: HomeViewController) {
        self.view = view
        
        getAllRoversPhoto(rover: .curiosity, page: page)
        switchRover()
    }
    
    internal func saveRover(_ rover: Routes.Rover) {
        if realmStorage.isEmpty {
            storage.rover = rover
            try! realm.write {
                realm.add(storage)
                collectionViewReloadData?()
            }
        } else {
            try! realm.write {
                realmStorage[0].rover = rover
                collectionViewReloadData?()
            }
        }
    }
    
    internal func saveDate(_ date: String) {
        if realmStorage.isEmpty {
            storage.date = date
            try! realm.write {
                realm.add(storage)
                collectionViewReloadData?()
            }
        } else {
            try! realm.write {
                realmStorage[0].date = date
                collectionViewReloadData?()
            }
        }
    }
    
    private func saveCameras(_ cameras: [RoverCameras]) {
        if realmStorage.isEmpty {
            storage.cameras = convertToRealmList(cameras)
            try! realm.write {
                realm.add(storage)
                view.cameraListView.tableViewReloadData?()
            }
        } else {
            try! realm.write {
                realmStorage[0].cameras = convertToRealmList(cameras)
                view.cameraListView.tableViewReloadData?()
            }
        }
    }
    
    internal func saveViewedMarsPhoto(model: HomeModel) {
        try! realm.write {
            realm.add(model)
        }
    }
    
    internal func openFullScreenPhoto(model: HomeModel) {
        let image = UIImage(data: model.image) ?? R.image.wallpaper()!
        let fullScreenVC = FullScreenImageModule(image: image).viewController()
        fullScreenVC.modalPresentationStyle = .fullScreen
        view.present(fullScreenVC, animated: true)
    }
    
    
    internal func showCalendarPicker() {
        var config = SwiftMessages.defaultConfig
        config.duration = .forever
        config.presentationStyle = .bottom
        config.presentationContext = .view(
            view.tabBarController!.view
        )
        
        config.dimMode = .color(
            color: .black.withAlphaComponent(0.8),
            interactive: true
        )
        
        SwiftMessages.show(
            config: config,
            view: view.actualCalendarView
        )
    }
    
    internal func hideCalendarPicker() {
        getAllPhotosByDate(
            rover: realmStorage[0].rover,
            date: realmStorage[0].date,
            page: page
        )
        SwiftMessages.hideAll()
    }
    
    internal func showCameraListView() {
        var config = SwiftMessages.defaultConfig
        config.duration = .forever
        config.presentationStyle = .bottom
        config.presentationContext = .view(
            view.tabBarController!.view
        )
        
        config.dimMode = .color(
            color: .black.withAlphaComponent(0.8),
            interactive: true
        )
        
        SwiftMessages.show(
            config: config,
            view: view.cameraListView
        )
    }
    
    internal func hideCameraListView() {
        homeModel.removeAll()
        getAllPhotosByOneCamera(
            rover: realmStorage[0].rover,
            camera: realmStorage[0].cameras[realmStorage[0].item].name,
            page: page
        )
        collectionViewReloadData?()
        SwiftMessages.hideAll()
    }
    
    private func initHomeModel(model: Photos, image: Data) {
        homeModel.append(
            .init(
                roverName: model.rover.name,
                cameraName: model.camera.name,
                cameraFullName: model.camera.fullName,
                image: image,
                earthDate: model.earthDate
            )
        )
    }
    
    private func switchRover() {
        roverDidChange = { [unowned self] rover in
            self.page = 1
            self.homeModel.removeAll()
            self.getAllRoversPhoto(rover: rover, page: self.page)
        }
    }
    
    internal func getAllRoversPhoto(rover: Routes.Rover, page: Int) {
        NetworkManager.getAllRoversPhoto(rover: rover, page: page) { [weak self] model in
            NetworkManager.srcToUIImage(url: model.imgSrc) { image in
                self?.initHomeModel(model: model, image: image)
                self?.saveCameras(model.rover.cameras)
                self?.collectionViewReloadData?()
            }
        }
    }
    
    internal func getAllPhotosByDate(rover: Routes.Rover, date: String, page: Int = 1) {
        NetworkManager.getAllPhotosByDate(rover: rover, date: date, page: page) { [weak self] model in
            NetworkManager.srcToUIImage(url: model.imgSrc) { image in
                self?.initHomeModel(model: model, image: image)
                self?.saveCameras(model.rover.cameras)
                self?.collectionViewReloadData?()
            }
        }
    }
    
    internal func getAllPhotosByOneCamera(rover: Routes.Rover, camera: String, page: Int = 1) {
        NetworkManager.getAllPhotosByOneCamera(rover: rover, camera: camera, page: page) { [weak self] model in
            NetworkManager.srcToUIImage(url: model.imgSrc) { image in
                self?.initHomeModel(model: model, image: image)
                self?.saveCameras(model.rover.cameras)
                self?.collectionViewReloadData?()
            }
        }
    }
}
