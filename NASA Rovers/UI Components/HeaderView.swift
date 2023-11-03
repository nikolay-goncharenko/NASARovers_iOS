//
//  HeaderView.swift
//  NASA Rovers
//
//  Created by Nikolay Goncharenko on 28.10.2023.
//

import UIKit

final class HeaderView: UIView {
    private let statusBarHeight = Screen.statusBarHeight
    
    private let placeholderView = UIView()
    
    private let titleLbl: UILabel = {
        var label = UILabel()
        label.textColor = .black
        label.font = R.font.sfProTextBold(size: 18)
        return label
    }()
    
    init(title: String) {
        super.init(frame: .zero)
        setupSubviews(title)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews(_ title: String) {
        backgroundColor = .white
        titleLbl.text = title
        addSubview(placeholderView)
        placeholderView.addSubview(titleLbl)
    }
    
    private func setupLayout() {
        snp.makeConstraints {
            $0.height.equalTo(statusBarHeight + 44)
        }
        
        placeholderView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(statusBarHeight)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        titleLbl.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
