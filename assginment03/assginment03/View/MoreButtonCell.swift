//
//  MoreButtonCell.swift
//  baemin03
//
//  Created by JIN on 11/12/25.
//

import UIKit
import Then
import SnapKit


class MoreButtonCell: UICollectionViewCell {
    
    private let topDividerView = UIView().then {
        $0.backgroundColor = .systemGray5
    }
    
    private let button = UIButton(type: .system).then {
        $0.setTitle("음식배달에서 더보기 >", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 15, weight: .medium)
        $0.setTitleColor(.black, for: .normal)
    }
    
    private let bottomDividerView = UIView().then {
        $0.backgroundColor = .systemGray6
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubviews(topDividerView, button, bottomDividerView)
        
        topDividerView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        button.snp.makeConstraints {
            $0.top.equalTo(topDividerView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(bottomDividerView.snp.top)
        }
        
        bottomDividerView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(10)
        }
    }
}
