//
//  RoverCardCell.swift
//  NASA Rovers
//
//  Created by Nikolay Goncharenko on 28.10.2023.
//

import UIKit

final class RoverCardCell: UICollectionViewCell {
    
    private let photoImg: UIImageView = {
        let image = UIImageView()
        let roundedCorners: UIRectCorner = [
            UIRectCorner.topLeft, UIRectCorner.topRight
        ]
        image.image = R.image.wallpaper()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 12
        image.layer.maskedCorners = CACornerMask(
            rawValue: roundedCorners.rawValue
        )
        return image
    }()
    
    private let roverNameLbl: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = R.font.sfProTextBold(size: 14)
        label.text = "Curiosity"
        label.isHidden = true
        return label
    }()
    
    private let cameraNameLbl: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = R.font.sfProTextRegular(size: 14)
        label.numberOfLines = 0
        label.text = "Camera name"
        return label
    }()
    
    private let dateLbl: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = R.font.sfProTextRegular(size: 12)
        label.text = "28.10.1023"
        return label
    }()
    
    private lazy var mainVertStack: UIStackView = {
        let stack = UIStackView()
        stack.addArrangedSubview(photoImg)
        stack.addArrangedSubview(roverNameLbl)
        stack.addArrangedSubview(cameraNameLbl)
        stack.addArrangedSubview(dateLbl)
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.alignment = .leading
        
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupSubviews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        backgroundColor = .white
        layer.cornerRadius = 16
        
        addSubview(mainVertStack)
        
        mainVertStack.isLayoutMarginsRelativeArrangement = true
        mainVertStack.directionalLayoutMargins = NSDirectionalEdgeInsets(
            top: 10, leading: 10, bottom: 10, trailing: 10)
    }
    
    private func setupLayout() {
        mainVertStack.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        photoImg.snp.makeConstraints {
            $0.height.equalTo(70)
        }
    }
    
    private func setupHandlers() {
        
    }
}

extension RoverCardCell {
    
    @discardableResult
    internal func setPhotoImg(_ image: UIImage) -> Self {
        photoImg.image = image
        return self
    }
    
    @discardableResult
    internal func setRoverNameLbl(_ text: String) -> Self {
        roverNameLbl.isHidden = false
        roverNameLbl.text = text
        return self
    }
    
    @discardableResult
    internal func setCameraNameLbl(_ text: String) -> Self {
        cameraNameLbl.text = text
        return self
    }
    
    @discardableResult
    internal func setDateLbl(_ text: String) -> Self {
        dateLbl.text = text
        return self
    }
}
