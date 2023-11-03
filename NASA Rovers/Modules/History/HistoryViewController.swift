//
//  HistoryViewController.swift
//  NASA Rovers
//
//  Created by Nikolay Goncharenko on 27.10.2023.
//

import UIKit

class HistoryViewController: BaseViewController {
    
    var viewModel: HistoryViewModel!
    
    private let headerView = HeaderView(
        title: "Viewed Photos"
    )
    
    private lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(
            frame: .zero, collectionViewLayout: collectionViewLayout
        )
        collection.register(RoverCardCell.self, forCellWithReuseIdentifier: "RoverCardCell")
        collection.backgroundColor = .clear
        collection.dataSource = self
        collection.delegate = self
        return collection
    }()
    
    private let collectionViewLayout: UICollectionViewLayout = {
        let item = NSCollectionLayoutItem(
            layoutSize: .init(
                widthDimension: .fractionalWidth(0.5),
                heightDimension: .fractionalHeight(1))
        )
        item.contentInsets = .init(top: 8, leading: 8, bottom: 8, trailing: 8)
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1),
                heightDimension: .absolute(165)),
            subitems: [item]
        )
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 8, leading: 8,
            bottom: 0, trailing: 8
        )
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }()
    
    override init() {
        super.init()
        tabBarItem = UITabBarItem(
            title: "Viewed",
            image: R.image.tabEye(),
            selectedImage: R.image.tabEye()
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupSubviews() {
        view.backgroundColor = .systemGray5
        
        view.addSubview(headerView)
        view.addSubview(collectionView)
    }
    
    override func setupLayout() {
        headerView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.top.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints {
            $0.horizontalEdges.bottom.equalToSuperview()
            $0.top.equalTo(headerView.snp.bottom)
        }
    }
    
    override func setupHandlers() {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }
}

extension HistoryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.realmData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RoverCardCell", for: indexPath) as? RoverCardCell {
            
            let model = viewModel.realmData[indexPath.item]
            let image = UIImage(data: model.image) ?? R.image.wallpaper()!
            
            cell.setPhotoImg(image)
            cell.setCameraNameLbl(model.cameraFullName)
            cell.setRoverNameLbl(model.roverName)
            cell.setDateLbl(model.earthDate)
            
            return cell
        } else {
            return RoverCardCell()
        }
    }
}

extension HistoryViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let model = viewModel.realmData[indexPath.item]
        viewModel.openFullScreenPhoto(model: model)
    }
}
