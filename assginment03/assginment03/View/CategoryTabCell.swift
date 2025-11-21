//
//  CategoryTabCell.swift
//  baemin03
//
//  Created by JIN on 11/12/25.
//

import UIKit
import Then
import SnapKit


class CategoryTabCell: UICollectionViewCell {
        
    // MARK: - Properties
    
    var onTabSelected: ((Int) -> Void)?
    private var selectedIndex: Int = 0
    private var tabButtons: [UIButton] = []
    
    private lazy var scrollView = UIScrollView().then {
        $0.showsHorizontalScrollIndicator = false
        $0.bounces = true
    }
    
    private let stackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 24
        $0.alignment = .center
        $0.distribution = .fill
    }
    
    private let dividerView = UIView().then {
        $0.backgroundColor = UIColor(white: 0.9, alpha: 1.0)
    }
    
    private let underlineView = UIView().then {
        $0.backgroundColor = .black
    }
    
    private let tabs = ["음식배달", "픽업", "장보기·쇼핑", "선물하기", "혜택모아"]
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        configureTabs()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if tabButtons.indices.contains(selectedIndex), tabButtons[selectedIndex].frame.width > 0 {
            updateUnderlinePosition(for: selectedIndex, animated: false)
        }
    }
    
    // MARK: - Setup
    
    private func setupUI() {
        contentView.backgroundColor = .white
        contentView.addSubviews(scrollView, dividerView, underlineView)
        scrollView.addSubview(stackView)
        
        scrollView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(33)
        }
        
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20))
            $0.height.equalToSuperview()
        }
        
        dividerView.snp.makeConstraints {
            $0.top.equalTo(scrollView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
            $0.bottom.equalToSuperview()
        }
        
        underlineView.snp.makeConstraints {
            $0.bottom.equalTo(dividerView.snp.top)
            $0.height.equalTo(2)
        }
    }
    
    private func configureTabs() {
        tabs.enumerated().forEach { index, title in
            let button = UIButton(type: .system).then {
                $0.setTitle(title, for: .normal)
                $0.titleLabel?.font = .systemFont(ofSize: 16, weight: index == 0 ? .bold : .regular)
                $0.setTitleColor(index == 0 ? .black : .gray, for: .normal)
                $0.tag = index
                $0.addTarget(self, action: #selector(tabButtonTapped), for: .touchUpInside)
            }
            stackView.addArrangedSubview(button)
            tabButtons.append(button)
        }
        
        selectedIndex = 0
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.layoutIfNeeded()
            if self.tabButtons.indices.contains(0) {
                self.updateUnderlinePosition(for: 0, animated: false)
            }
        }
    }
    
    // MARK: - Actions
    
    @objc private func tabButtonTapped(_ sender: UIButton) {
        let index = sender.tag
        updateSelectedTab(index: index)
        onTabSelected?(index)
    }
    
    // MARK: - Public Methods
    
    func updateSelectedTab(index: Int) {
        guard tabButtons.indices.contains(index) else { return }
        
        selectedIndex = index
        
        tabButtons.forEach { button in
            button.titleLabel?.font = .systemFont(ofSize: 16, weight: .regular)
            button.setTitleColor(.gray, for: .normal)
        }
        
        let selectedButton = tabButtons[index]
        selectedButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        selectedButton.setTitleColor(.black, for: .normal)
        
        updateUnderlinePosition(for: index, animated: true)
        
        scrollToButton(at: index)
    }
    
    // MARK: - Private Methods
    
    private func updateUnderlinePosition(for index: Int, animated: Bool) {
        guard tabButtons.indices.contains(index) else { return }
        
        let selectedButton = tabButtons[index]
        
        guard selectedButton.frame.width > 0 else { return }
        
        let buttonFrame = selectedButton.frame
        let buttonX = buttonFrame.origin.x + 20
        let buttonWidth = buttonFrame.width
        
        if animated {
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {
                self.underlineView.snp.remakeConstraints {
                    $0.bottom.equalTo(self.dividerView.snp.top)
                    $0.leading.equalToSuperview().offset(buttonX)
                    $0.width.equalTo(buttonWidth)
                    $0.height.equalTo(2)
                }
                self.layoutIfNeeded()
            }
        } else {
            self.underlineView.snp.remakeConstraints {
                $0.bottom.equalTo(self.dividerView.snp.top)
                $0.leading.equalToSuperview().offset(buttonX)
                $0.width.equalTo(buttonWidth)
                $0.height.equalTo(2)
            }
            self.layoutIfNeeded()
        }
    }
    
    private func scrollToButton(at index: Int) {
        guard tabButtons.indices.contains(index) else { return }
        
        let button = tabButtons[index]
        let buttonFrame = button.frame
        let scrollViewWidth = scrollView.frame.width
        let targetX = buttonFrame.midX - (scrollViewWidth / 2)
        let maxOffsetX = scrollView.contentSize.width - scrollViewWidth
        let offsetX = max(0, min(targetX, maxOffsetX))
        
        scrollView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
}
