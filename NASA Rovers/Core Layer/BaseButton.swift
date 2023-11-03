//
//  BaseButton.swift
//  NASA Rovers
//
//  Created by Nikolay Goncharenko on 28.10.2023.
//

import UIKit

class BaseButton: UIButton {
    
    init() {
        super.init(frame: .zero)
    }
    
    override var isHighlighted: Bool {
        didSet {
            alpha = isHighlighted ? 0.6 : 1.0
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
