//
//  CameraListView.swift
//  NASA Rovers
//
//  Created by Nikolay Goncharenko on 01.11.2023.
//

import UIKit
import RealmSwift

final class CameraListView: UIStackView {
    
    internal var closeCameraListView: (() -> Void)?
    internal var tableViewReloadData: (() -> Void)?
    
    let realm = try! Realm()
    lazy var realmStorage = realm.objects(TempStorage.self)
    
    private let indicatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.6)
        view.layer.cornerRadius = 2
        return view
    }()
    
    private lazy var indicatorStack: UIStackView = {
        let stack = UIStackView()
        stack.addArrangedSubview(indicatorView)
        stack.alignment = .center
        stack.axis = .vertical
        return stack
    }()
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = .clear
        table.dataSource = self
        table.delegate = self
        return table
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupSubviews()
        setupLayout()
        setuphandlers()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        backgroundColor = .white
        distribution = .fill
        axis = .vertical
        spacing = 16
        
        isLayoutMarginsRelativeArrangement = true
        directionalLayoutMargins = NSDirectionalEdgeInsets(
            top: 16, leading: 10, bottom: 10, trailing: 10)
        
        let roundedCorners: UIRectCorner = [
            UIRectCorner.topLeft, UIRectCorner.topRight
        ]
        layer.cornerRadius = 20
        layer.maskedCorners = CACornerMask(
            rawValue: roundedCorners.rawValue
        )
        
        addArrangedSubview(indicatorStack)
        addArrangedSubview(tableView)
    }
    
    private func setupLayout() {
        indicatorView.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: 30, height: 4))
        }
        
        tableView.snp.makeConstraints {
            $0.height.equalTo(300)
        }
    }
    
    private func setuphandlers() {
        tableViewReloadData = { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

extension CameraListView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return realmStorage[0].cameras.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        
        let camera = realmStorage[0].cameras[indexPath.item].fullName
        cell.textLabel?.text = camera
        return cell
    }
}

extension CameraListView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        try! realm.write {
            realmStorage[0].item = indexPath.item
        }
        
        closeCameraListView?()
    }
}
