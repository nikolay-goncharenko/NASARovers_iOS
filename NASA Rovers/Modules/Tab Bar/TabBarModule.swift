//
//  TabBarModule.swift
//  NASA Rovers
//
//  Created by Nikolay Goncharenko on 26.10.2023.
//

import UIKit

final class TabBarModule: BaseModule {
    
    let view: TabBarViewController
    let viewModel: TabBarViewModel
    
    init() {
        view = TabBarViewController()
        viewModel = TabBarViewModel()
        view.viewModel = viewModel
    }
    
    func viewController() -> UIViewController {
        return view
    }
}
