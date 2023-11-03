//
//  FullScreenImageViewModel.swift
//  NASA Rovers
//
//  Created by Nikolay Goncharenko on 02.11.2023.
//

import UIKit

final class FullScreenImageViewModel {
    unowned var view: FullScreenImageViewController
    
    init(view: FullScreenImageViewController, image: UIImage) {
        self.view = view
        self.view.initImage(image)
    }
    
    @objc internal func closeFullScreen() {
        view.dismiss(animated: true)
    }
    
    @objc internal func handlePinchGesture(_ sender: UIPinchGestureRecognizer) {
        if let view = sender.view {
            view.transform = view.transform.scaledBy(x: sender.scale, y: sender.scale)
            sender.scale = 1
        }
    }
    
    @objc internal func handlePanGesture(_ sender: UIPanGestureRecognizer) {
        if let view = sender.view {
            let translation = sender.translation(in: view)
            view.transform = view.transform.translatedBy(x: translation.x, y: translation.y)
            sender.setTranslation(CGPoint.zero, in: view)
        }
    }
    
    @objc internal func handleDoubleTapGesture(_ sender: UITapGestureRecognizer) {
        if let view = sender.view {
            UIView.animate(withDuration: 0.2) {
                view.transform = .identity
            }
        }
    }
}
