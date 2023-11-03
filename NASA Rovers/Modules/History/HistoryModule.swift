//
//  HistoryModule.swift
//  NASA Rovers
//
//  Created by Nikolay Goncharenko on 26.10.2023.
//

import UIKit

class HistoryModule: BaseModule {
    
    let view: HistoryViewController
    let viewModel: HistoryViewModel
    
    init() {
        view = HistoryViewController()
        viewModel = HistoryViewModel(view: view)
        view.viewModel = viewModel
    }
    
    func viewController() -> UIViewController {
        return view
    }
}
