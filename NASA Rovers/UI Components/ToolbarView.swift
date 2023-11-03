//
//  ToolbarView.swift
//  NASA Rovers
//
//  Created by Nikolay Goncharenko on 28.10.2023.
//

import UIKit

final class ToolbarView: UIStackView {
    
    // MARK: Control Handlers
    internal var roverHandler: ((Routes.Rover) -> Void)?
    internal var calendarHandler: (() -> Void)?
    internal var cameraHandler: (() -> Void)?
    
    private let segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(
            items: [
                Rover.curiosity.name,
                Rover.opportunity.name,
                Rover.spirit.name
            ]
        )
        segmentedControl.selectedSegmentIndex = 0
        return segmentedControl
    }()
    
    private let calendarBtn: BaseButton = {
        let button = BaseButton()
        button.setImage(R.image.calendar(), for: .normal)
        button.setImage(R.image.calendar(), for: .highlighted)
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = .black
        return button
    }()
    
    private let cameraBtn: BaseButton = {
        let button = BaseButton()
        button.setImage(R.image.camera(), for: .normal)
        button.setImage(R.image.camera(), for: .highlighted)
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = .black
        return button
    }()
    
    init() {
        super.init(frame: .zero)
        setupSubviews()
        setupLayout()
        setupHandlers()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        backgroundColor = .white
        
        addArrangedSubview(segmentedControl)
        addArrangedSubview(calendarBtn)
        addArrangedSubview(cameraBtn)
        
        axis = .horizontal
        distribution = .equalSpacing
        alignment = .center
        
        isLayoutMarginsRelativeArrangement = true
        directionalLayoutMargins = NSDirectionalEdgeInsets(
            top: 0, leading: 6, bottom: 0, trailing: 6)
    }
    
    private func setupLayout() {
        snp.makeConstraints {
            $0.height.equalTo(50)
        }
        
        [calendarBtn, cameraBtn].forEach { button in
            button.snp.makeConstraints {
                $0.size.equalTo(24)
            }
        }
    }
    
    private func setupHandlers() {
        segmentedControl.addTarget(self, action: #selector(selectRover), for: .valueChanged)
        calendarBtn.addTarget(self, action: #selector(selectDate), for: .touchUpInside)
        cameraBtn.addTarget(self, action: #selector(selectCamera), for: .touchUpInside)
    }
    
    @objc private func selectRover(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case Rover.curiosity.index:
            roverHandler?(Routes.Rover.curiosity)
        case Rover.opportunity.index:
            roverHandler?(Routes.Rover.opportunity)
        case Rover.spirit.index:
            roverHandler?(Routes.Rover.spirit)
        default:
            break
        }
    }
    
    @objc private func selectDate() {
        calendarHandler?()
    }
    
    @objc private func selectCamera() {
        cameraHandler?()
    }
}

extension ToolbarView {
    enum Rover: Int, CaseIterable {
        case curiosity, opportunity, spirit
        
        var name: String {
            return ["Curiosity", "Opportunity", "Spirit"][self.rawValue]
        }
        
        var index: Int {
            return [0, 1, 2][self.rawValue]
        }
    }
}
