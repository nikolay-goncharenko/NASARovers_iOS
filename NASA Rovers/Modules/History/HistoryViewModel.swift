//
//  HistoryViewModel.swift
//  NASA Rovers
//
//  Created by Nikolay Goncharenko on 27.10.2023.
//

import UIKit
import RealmSwift

class HistoryViewModel {
    unowned var view: HistoryViewController
    
    let realm = try! Realm()
    lazy var realmData = realm.objects(HomeModel.self)
    
    init(view: HistoryViewController) {
        self.view = view
    }
    
    internal func openFullScreenPhoto(model: HomeModel) {
        let image = UIImage(data: model.image) ?? R.image.wallpaper()!
        let fullScreenVC = FullScreenImageModule(image: image).viewController()
        fullScreenVC.modalPresentationStyle = .fullScreen
        view.present(fullScreenVC, animated: true)
    }
}
