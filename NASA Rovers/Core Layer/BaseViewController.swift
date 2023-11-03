//
//  BaseViewController.swift
//  NASA Rovers
//
//  Created by Nikolay Goncharenko on 26.10.2023.
//

import UIKit

class BaseViewController: UIViewController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        setupLayout()
        setupHandlers()
    }
    
    func setupSubviews() {
        fatalError("setupSubviews has not been implemented")
    }
    
    func setupLayout() {
        fatalError("setupLayout has not been implemented")
    }
    
    func setupHandlers() {
        fatalError("setupHandlers has not been implemented")
    }
}
