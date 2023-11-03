//
//  Screen.swift
//  NASA Rovers
//
//  Created by Nikolay Goncharenko on 28.10.2023.
//

import UIKit

extension UIApplication {
    static var statusBarHeight: CGFloat {
        if #available(iOS 13.0, *) {
            let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
            let statusBarManager = windowScene?.statusBarManager
            let statusBarHeight = statusBarManager?.statusBarFrame.height
            return statusBarHeight ?? 0
        } else {
            return shared.statusBarFrame.standardized.height
        }
    }
}

struct Screen {
    static var width: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    static var height: CGFloat {
        return UIScreen.main.bounds.height
    }
    
    static var statusBarHeight: CGFloat {
        return UIApplication.statusBarHeight
    }
}
