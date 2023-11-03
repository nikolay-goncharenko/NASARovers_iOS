//
//  FullScreenImageViewController.swift
//  NASA Rovers
//
//  Created by Nikolay Goncharenko on 02.11.2023.
//

import UIKit

final class FullScreenImageViewController: BaseViewController, UIScrollViewDelegate {
    
    var viewModel: FullScreenImageViewModel!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private let closeBtn: BaseButton = {
        let button = BaseButton()
        button.setImage(R.image.close(), for: .normal)
        button.setImage(R.image.close(), for: .highlighted)
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = .white
        return button
    }()
    
    private lazy var closeBtnSack: UIStackView = {
        let stack = UIStackView()
        stack.addArrangedSubview(UIView())
        stack.addArrangedSubview(closeBtn)
        stack.distribution = .fill
        stack.alignment = .center
        stack.axis = .horizontal
        stack.backgroundColor = .clear
        return stack
    }()
    
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView(frame: .zero)
        view.delegate = self
        return view
    }()
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .center
        view.isUserInteractionEnabled = true
        view.isMultipleTouchEnabled = true
        return view
    }()
    
    override func setupSubviews() {
        view.backgroundColor = .black
        
        view.addSubview(scrollView)
        view.addSubview(closeBtnSack)
        scrollView.addSubview(imageView)
    }
    
    override func setupLayout() {
        closeBtnSack.snp.makeConstraints {
            $0.top.equalToSuperview()
                .inset(Screen.statusBarHeight + 10)
            $0.width.equalToSuperview()
            $0.height.equalTo(30)
        }
        
        scrollView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.top.equalTo(closeBtnSack.snp.bottom).offset(10)
            $0.bottom.equalToSuperview()
        }
        
        imageView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    override func setupHandlers() {
        closeBtn.addTarget(
            viewModel,
            action: #selector(viewModel.closeFullScreen),
            for: .touchUpInside
        )
        
        imageView.addGestureRecognizer(
            UIPinchGestureRecognizer(
                target: viewModel,
                action: #selector(viewModel.handlePinchGesture)
            )
        )
        
        imageView.addGestureRecognizer(
            UIPanGestureRecognizer(
                target: viewModel,
                action: #selector(viewModel.handlePanGesture)
            )
        )
        
        let doubleTapGesture = UITapGestureRecognizer(
            target: viewModel,
            action: #selector(viewModel.handleDoubleTapGesture)
        )
        doubleTapGesture.numberOfTapsRequired = 2
        imageView.addGestureRecognizer(doubleTapGesture)
    }
    
    internal func initImage(_ image: UIImage) {
        imageView.image = image
    }
}
