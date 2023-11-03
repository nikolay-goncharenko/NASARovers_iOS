//
//  TabBarViewModel.swift
//  NASA Rovers
//
//  Created by Nikolay Goncharenko on 26.10.2023.
//

import UIKit

final class TabBarViewModel {
    
//    var model: TabBarModel
//
//    init(model: TabBarModel) {
//        self.model = model
//    }
    
//    unowned var view: TabBarViewController
//    
//    init(view: TabBarViewController) {
//        self.view = view
//    }
    
    func viewConstollers() -> [UIViewController] {
        let home = HomeModule().viewController()
        let history = HistoryModule().viewController()
        return [home, history]
    }
}
