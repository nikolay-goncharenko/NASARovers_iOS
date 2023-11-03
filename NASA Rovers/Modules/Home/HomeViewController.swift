//
//  HomeViewController.swift
//  NASA Rovers
//
//  Created by Nikolay Goncharenko on 26.10.2023.
//

import UIKit

final class HomeViewController: BaseViewController {
    
    var viewModel: HomeViewModel!
    
    private let headerView = HeaderView(
        title: "Mars Rover Photos"
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
    
    private let toolbarView = ToolbarView()
    
    private let calendarDatePicker = CalendarDatePicker()
    private let calendarDateView = CalendarDateView()
    
    internal var actualCalendarView: UIView {
        if #available(iOS 14, *) {
            return calendarDatePicker
        } else {
            return calendarDateView
        }
    }
    
    internal var cameraListView = CameraListView()
    
    override init() {
        super.init()
        tabBarItem = UITabBarItem(
            title: "Home",
            image: R.image.tabHome(),
            selectedImage: R.image.tabHome()
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupSubviews() {
        view.backgroundColor = .systemGray5
        
        view.addSubview(headerView)
        view.addSubview(collectionView)
        view.addSubview(toolbarView)
    }
    
    override func setupLayout() {
        headerView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.top.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.top.equalTo(headerView.snp.bottom)
            $0.bottom.equalTo(toolbarView.snp.top)
        }
        
        toolbarView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    override func setupHandlers() {
        viewModel.collectionViewReloadData = { [weak self] in
            self?.collectionView.reloadData()
        }
        
        toolbarView.roverHandler = { [weak self] rover in
            self?.viewModel.roverDidChange?(rover)
            self?.viewModel.saveRover(rover)
        }
        
        toolbarView.calendarHandler = { [weak self] in
            self?.viewModel.showCalendarPicker()
        }
        
        toolbarView.cameraHandler = { [weak self] in
            self?.viewModel.showCameraListView()
        }
        
        cameraListView.closeCameraListView = { [weak self] in
            self?.viewModel.hideCameraListView()
        }
        
        calendarDatePicker.takeSelectedDate = { [weak self] date in
            self?.viewModel.homeModel.removeAll()
            self?.viewModel.saveDate(date)
        }
        
        calendarDatePicker.hideCalendar = { [weak self] in
            self?.viewModel.hideCalendarPicker()
        }
        
        calendarDateView.takeSelectedDate = { [weak self] date in
            self?.viewModel.homeModel.removeAll()
            self?.viewModel.saveDate(date)
        }
        
        calendarDateView.hideCalendar = { [weak self] in
            self?.viewModel.hideCalendarPicker()
        }
    }
}

extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.homeModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RoverCardCell", for: indexPath) as? RoverCardCell {

            let model = viewModel.homeModel[indexPath.item]
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

extension HomeViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let model = viewModel.homeModel[indexPath.item]
        viewModel.saveViewedMarsPhoto(model: model)
        viewModel.openFullScreenPhoto(model: model)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak viewModel] in
            guard let viewModel else { return }
            
            if indexPath.item == (viewModel.homeModel.count - 1) {
                viewModel.page += 1
//                viewModel.getAllRoversPhoto(
//                    rover: viewModel.realmStorage[0].rover,
//                    page: viewModel.page
//                )
            }
        }
    }
}
