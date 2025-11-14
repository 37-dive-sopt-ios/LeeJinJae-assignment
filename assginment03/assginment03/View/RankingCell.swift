//
//  rankingCell.swift
//  baemin03
//
//  Created by JIN on 11/12/25.
//

import UIKit
import Then
import SnapKit

class RankingCell: UICollectionViewCell {
    
    private let titleLabel = UILabel().then {
        $0.text = "우리동네 한그릇 랭킹"
        $0.font = .size17
        $0.textColor = .white
    }
    
    let backgroundGradientView: GradientView = {
        let gradientView = GradientView()
        gradientView.colors = [.white, UIColor(rgb: 0x7276FF)]
        gradientView.locations = [0.5, 0.75]
        gradientView.startPoint = CGPoint(x: 0.5, y: 1)
        gradientView.endPoint = CGPoint(x: 0.5, y: 0)
        return gradientView
    }()
    
    private let bottomDividerView = UIView().then {
        $0.backgroundColor = .systemGray6
    }
        
    let rankedkMenuItems: [Menu] = [
        Menu(
            storeName: "백억보쌈제육",
            rating: 5.0,
            reviewCount: 1973,
            menuName: "[든든한 한끼] 보쌈 막국수",
            discountRate: 25,
            currentPrice: 12000,
            originalPrice: 16000,
            notice: "최소주문금액 없음"
        ),
        Menu(
            storeName: "한솥도시락",
            rating: 4.8,
            reviewCount: 2501,
            menuName: "치킨마요 + 돈까스",
            discountRate: 10,
            currentPrice: 6300,
            originalPrice: 7000,
            notice: "배달팁 0원"
        ),
        Menu(
            storeName: "맘스터치",
            rating: 4.9,
            reviewCount: 3210,
            menuName: "싸이순살 세트",
            discountRate: nil,
            currentPrice: 8900,
            originalPrice: nil,
            notice: "15분 내 픽업 가능"
        ),
        Menu(
            storeName: "홍콩반점0410",
            rating: 4.7,
            reviewCount: 1542,
            menuName: "짜장면 + 탕수육 소",
            discountRate: 20,
            currentPrice: 10400,
            originalPrice: 13000,
            notice: "최소주문금액 없음"
        )
    ]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 8
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.delegate = self
        cv.dataSource = self
        cv.showsHorizontalScrollIndicator = false
        cv.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        cv.register(RankingItemCell.self, forCellWithReuseIdentifier: RankingItemCell.identifier)
        return cv
    }()
    
    private func setupUI() {
        contentView.addSubview(backgroundGradientView)
        backgroundGradientView.addSubviews(titleLabel, collectionView, bottomDividerView)
        
        backgroundGradientView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalToSuperview().offset(20)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalTo(backgroundGradientView)
            $0.bottom.equalTo(bottomDividerView.snp.top)
        }
        
        bottomDividerView.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(10)
        }
    }
}

//MARK: - UICollectionViewDelegate

extension RankingCell: UICollectionViewDelegate {
    
}

//MARK: - UICollectionViewDataSource

extension RankingCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        rankedkMenuItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: RankingItemCell.identifier,
            for: indexPath
        ) as! RankingItemCell
        cell.configure(with: rankedkMenuItems[indexPath.item])
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension RankingCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 170, height: 280)
    }
}

//MARK: - RankingItemCell

class RankingItemCell: UICollectionViewCell {
    
    static let identifier = "RankingItemCell"
        
    private let menuImageView = UIImageView().then {
        $0.backgroundColor = .systemGray6
        $0.layer.cornerRadius = 12
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFill
    }
    
    private let storeInfoLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 11)
        $0.textColor = .systemGray
        $0.numberOfLines = 1
    }
    
    private let menuNameLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14, weight: .medium)
        $0.textColor = .black
        $0.numberOfLines = 2
    }
    
    private let discountLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16, weight: .bold)
        $0.textColor = .systemRed
    }
    
    private let currentPriceLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16, weight: .bold)
        $0.textColor = .black
    }
    
    private let originalPriceLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 12)
        $0.textColor = .systemGray3
    }
    
    private let noticeLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 11)
        $0.textColor = .systemBlue
        $0.numberOfLines = 1
    }
    
    private lazy var priceStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 4
        $0.alignment = .center
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.backgroundColor = .clear
        backgroundColor = .clear
        
        contentView.addSubviews(
            menuImageView,
            storeInfoLabel,
            menuNameLabel,
            priceStackView,
            noticeLabel
        )
        
        priceStackView.addArrangedSubview(discountLabel)
        priceStackView.addArrangedSubview(currentPriceLabel)
        priceStackView.addArrangedSubview(originalPriceLabel)
        
        menuImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.trailing.equalToSuperview().inset(4)
            $0.height.equalTo(150)
        }
        
        storeInfoLabel.snp.makeConstraints {
            $0.top.equalTo(menuImageView.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(4)
        }
        
        menuNameLabel.snp.makeConstraints {
            $0.top.equalTo(storeInfoLabel.snp.bottom).offset(4)
            $0.leading.trailing.equalToSuperview().inset(4)
        }
        
        priceStackView.snp.makeConstraints {
            $0.top.equalTo(menuNameLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().inset(4)
        }
        
        noticeLabel.snp.makeConstraints {
            $0.top.equalTo(priceStackView.snp.bottom).offset(6)
            $0.leading.trailing.equalToSuperview().inset(4)
            $0.bottom.lessThanOrEqualToSuperview().inset(8)
        }
    }
    
    func configure(with menu: Menu) {
        let reviewText = "(\(menu.reviewCount.formattedWithComma()))"
        storeInfoLabel.text = "\(menu.storeName) ⭐️ \(String(format: "%.1f", menu.rating)) \(reviewText)"
        
        menuNameLabel.text = menu.menuName
        
        if let discountRate = menu.discountRate {
            discountLabel.text = "\(discountRate)%"
            discountLabel.isHidden = false
        } else {
            discountLabel.isHidden = true
        }
        
        currentPriceLabel.text = "\(menu.currentPrice.formattedWithComma())원"
        
        if let originalPrice = menu.originalPrice {
            let attributedString = NSMutableAttributedString(string: "\(originalPrice.formattedWithComma())원")
            attributedString.addAttribute(
                .strikethroughStyle,
                value: NSUnderlineStyle.single.rawValue,
                range: NSRange(location: 0, length: attributedString.length)
            )
            originalPriceLabel.attributedText = attributedString
            originalPriceLabel.isHidden = false
        } else {
            originalPriceLabel.isHidden = true
        }
        
        noticeLabel.text = menu.notice
    }
}
