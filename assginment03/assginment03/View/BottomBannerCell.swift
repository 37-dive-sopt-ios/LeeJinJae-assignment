//
//  BottomBannerCell.swift
//  baemin03
//
//  Created by JIN on 11/12/25.
//

import UIKit
import Then
import SnapKit

class BottomBannerCell: UICollectionViewCell {
    
    private let bannerView = UIImageView().then {
        $0.image = .teslaGigafactory2
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFill
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(bannerView)
        
        bannerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

