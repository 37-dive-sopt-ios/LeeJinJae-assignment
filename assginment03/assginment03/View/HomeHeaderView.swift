//
//  HomeHeaderView.swift
//  baemin03
//
//  Created by JIN on 11/10/25.
//

import UIKit
import SnapKit
import Then

class HomeHeaderView: UIView, Identity {
    
    // MARK: - UI Components
    
    private let myHomeLabel = UILabel().then {
        $0.text = "우리집"
        $0.font = .size17
        $0.textColor = .black
        $0.textAlignment = .left
    }

    private let myHomeImageStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.alignment = .center
        $0.spacing = 12
    }

    private let discountImageView = UIImageView().then {
        $0.image = .discount
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
    }

    private let bellImageView = UIImageView().then {
        $0.image = .bell
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
    }
    
    private let cartImageView = UIImageView().then {
        $0.image = .cart
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
    }
    
    let headerSearchBar = UITextField().then {
        $0.placeholder = "검색"
        $0.font = .size17
        $0.textColor = .black
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 20
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.black.cgColor
        $0.clipsToBounds = true
        $0.addLeftPadding()
        let searchIcon = UIImageView(frame: CGRect(x: 12, y: 10, width: 24, height: 24))
        searchIcon.image = .magnifyingglass
        let rightView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 42))
        rightView.addSubview(searchIcon)
        $0.rightView = rightView
        $0.rightViewMode = .always
        $0.attributedPlaceholder = NSAttributedString(
            string: "우리동네 맛집 검색",
            attributes: [.foregroundColor: UIColor(resource: .baeminGray)]
        )
    }
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private func setupUI() {
        backgroundColor = .white
        
        addSubviews(myHomeLabel, myHomeImageStackView, headerSearchBar)
        myHomeImageStackView.addArrangedSubviews(discountImageView, bellImageView, cartImageView)
        
        myHomeLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(60)
            $0.leading.equalToSuperview().offset(24)
        }
        
        myHomeImageStackView.snp.makeConstraints {
            $0.centerY.equalTo(myHomeLabel)
            $0.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(24)
        }
        
        discountImageView.snp.makeConstraints {
            $0.width.height.equalTo(24)
        }
        
        bellImageView.snp.makeConstraints {
            $0.width.height.equalTo(24)
        }
        
        cartImageView.snp.makeConstraints {
            $0.width.height.equalTo(24)
        }
        
        headerSearchBar.snp.makeConstraints {
            $0.top.equalTo(myHomeLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(42)
            $0.bottom.equalToSuperview().inset(16)
        }
    }
}
