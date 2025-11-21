//
//  BannerCell.swift
//  baemin03
//
//  Created by JIN on 11/12/25.
//

import Then
import SnapKit
import UIKit

class BannerCell: UICollectionViewCell {
    
    let backgroundGradientView: GradientView = {
            let gradientView = GradientView()
            gradientView.colors = [.white, UIColor(rgb: 0xC9F9F0)]
            gradientView.locations = [0, 1]
            gradientView.startPoint = .init(x: 0.5, y: 0)
            gradientView.endPoint = .init(x: 0.5, y: 1)
            return gradientView
        }()
    
    private let titleLabel = UILabel().then {
        $0.text = "B마트🍋"
        $0.font = .systemFont(ofSize: 18, weight: .bold)
        $0.textColor = .black
    }
    
    private let descriptionLabel = UILabel().then {
        $0.text = "전상품 쿠폰팩 + 60%특가 >"
        $0.font = .systemFont(ofSize: 16, weight: .semibold)
        $0.textColor = .black
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(backgroundGradientView)
        backgroundGradientView.addSubviews(titleLabel, descriptionLabel)
        
        backgroundGradientView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalToSuperview().offset(20)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.leading.equalTo(titleLabel)
            $0.bottom.equalToSuperview().offset(-16)
        }
    }
}
