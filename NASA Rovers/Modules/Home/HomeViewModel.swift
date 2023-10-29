//
//  HomeViewModel.swift
//  NASA Rovers
//
//  Created by Nikolay Goncharenko on 26.10.2023.
//

import UIKit
import SwiftMessages

class HomeViewModel {
    unowned var view: HomeViewController
    
    init(view: HomeViewController) {
        self.view = view
    }
    
    internal func showCalendar() {
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
    
    internal func selectCamera() {
        print("Camera was selected from Home Screen")
    }
}
