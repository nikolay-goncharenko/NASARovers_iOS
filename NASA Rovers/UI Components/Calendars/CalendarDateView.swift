//
//  CalendarDateView.swift
//  NASA Rovers
//
//  Created by Nikolay Goncharenko on 29.10.2023.
//

import UIKit

final class CalendarDateView: UIStackView {
    
    internal var takeSelectedDate: ((String) -> Void)?
    internal var hideCalendar: (() -> Void)?
    
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
    
    private let calendarDateView: CalendarView = {
        let calendar = CalendarView()
        calendar.style.activeDate = .init(
            textColor: .white, backgroundColor: .black)
        calendar.style.inActiveDate = .init(
            textColor: .black, backgroundColor: .clear)
        return calendar
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
        addArrangedSubview(calendarDateView)
    }
    
    private func setupLayout() {
        indicatorView.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: 30, height: 4))
        }
        
        calendarDateView.snp.makeConstraints {
            $0.height.equalTo(300)
        }
    }
    
    private func selectedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }
    
    private func setuphandlers() {
        calendarDateView.didSelectDate = { [weak self] in
            guard let self = self, let day = $0 else { return }
            self.takeSelectedDate?(self.selectedDate(day.date))
            self.hideCalendar?()
        }
    }
}
