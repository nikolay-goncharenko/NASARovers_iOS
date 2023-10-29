//
//  CalendarDatePicker.swift
//  NASA Rovers
//
//  Created by Nikolay Goncharenko on 28.10.2023.
//

import UIKit

final class CalendarDatePicker: UIStackView {
    
    internal var takeSelectedDate: ((String) -> Void)?
    internal var hideCalendar: (() -> Void)?
    
    private let indicatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.6)
        view.layer.cornerRadius = 2
        return view
    }()
    
    private let calendarDatePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.date = Calendar.current.date(
            byAdding: .day, value: .zero, to: Date()
        ) ?? Date()
        datePicker.tintColor = .systemBlue
        datePicker.datePickerMode = .date
        if #available(iOS 14.0, *) {
            datePicker.preferredDatePickerStyle = .inline
        } else {
            // Fallback on earlier versions
        }
        return datePicker
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
        alignment = .center
        axis = .vertical
        
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
        
        addArrangedSubview(indicatorView)
        addArrangedSubview(calendarDatePicker)
    }
    
    private func setupLayout() {
        indicatorView.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: 30, height: 4))
        }
        
        calendarDatePicker.snp.makeConstraints {
            $0.height.equalTo(300)
        }
    }
    
    private func setuphandlers() {
        calendarDatePicker.addTarget(
            self,
            action: #selector(datePicker),
            for: .valueChanged
        )
    }
    
    @objc private func datePicker(_ sender: UIDatePicker) {
        takeSelectedDate?(sender.date.description)
        hideCalendar?()
        print(sender.date.description)
    }
}
