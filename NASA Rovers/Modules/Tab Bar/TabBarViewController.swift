//
//  TabBarViewController.swift
//  NASA Rovers
//
//  Created by Nikolay Goncharenko on 26.10.2023.
//

import UIKit

final class TabBarViewController: BaseViewController {
    
    var viewModel: TabBarViewModel!
    
    private let tabBarControl = UITabBarController()
    
    override func setupSubviews() {
        addChild(tabBarControl)
        view.addSubview(tabBarControl.view)
        
        tabBarControl.didMove(toParent: self)
        tabBarControl.setViewControllers(
            viewModel.viewConstollers(),
            animated: false
        )
        tabBarControl.selectedIndex = 0
        
        tabBarControl.tabBar.backgroundColor = .white
        tabBarControl.tabBar.tintColor = .black
        tabBarControl.tabBar.unselectedItemTintColor = .lightGray
    }
    
    override func setupLayout() {
        tabBarControl.view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    override func setupHandlers() {
        
    }
}
