//
//  FullScreenImageModule.swift
//  NASA Rovers
//
//  Created by Nikolay Goncharenko on 02.11.2023.
//

import UIKit

final class FullScreenImageModule: BaseModule {
    let view: FullScreenImageViewController
    let viewModel: FullScreenImageViewModel
    
    init(image: UIImage) {
        view = FullScreenImageViewController()
        viewModel = FullScreenImageViewModel(
            view: view, image: image
        )
        view.viewModel = viewModel
    }
    
    func viewController() -> UIViewController {
        return view
    }
}
