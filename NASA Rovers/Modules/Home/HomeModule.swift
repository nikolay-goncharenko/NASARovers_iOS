//
//  HomeModule.swift
//  NASA Rovers
//
//  Created by Nikolay Goncharenko on 26.10.2023.
//

import UIKit

class HomeModule: BaseModule {
    let view: HomeViewController
    let viewModel: HomeViewModel
    
    init() {
        view = HomeViewController()
        viewModel = HomeViewModel(view: view)
        view.viewModel = viewModel
    }
    
    func viewController() -> UIViewController {
        return view
    }
}
