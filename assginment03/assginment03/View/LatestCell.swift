//
//  LatestCell.swift
//  baemin03
//
//  Created by JIN on 11/13/25.

import UIKit
import SnapKit
import Then

class LatestCell: UICollectionViewCell {
        
    private let titleLabel = UILabel().then {
        $0.text = "최근에 주문했어요"
        $0.font = .size17
        $0.textColor = .black
    }
    
    private let infoButton = UIButton().then {
        $0.setImage(.information, for: .normal)
        $0.tintColor = .systemGray
    }
    
    private let viewAllButton = UIButton().then {
        $0.setTitle("전체보기", for: .normal)
        $0.setTitleColor(.systemGray, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 14)
        $0.setImage(.right, for: .normal)
        $0.tintColor = .systemGray
        $0.semanticContentAttribute = .forceRightToLeft  // 이미지를 오른쪽에
    }
    
    private let bottomDividerView = UIView().then {
        $0.backgroundColor = .systemGray6
    }
    
    private let stores = Store.mockData
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 12
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.delegate = self
        cv.dataSource = self
        cv.showsHorizontalScrollIndicator = false
        cv.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        cv.register(LatestStoreItemCell.self, forCellWithReuseIdentifier: LatestStoreItemCell.identifier)
        return cv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.backgroundColor = .white
        
        contentView.addSubviews(titleLabel, infoButton, viewAllButton, collectionView, bottomDividerView)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalToSuperview().offset(20)
        }
        
        infoButton.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel)
            $0.leading.equalTo(titleLabel.snp.trailing).offset(4)
            $0.width.height.equalTo(20)
        }
        
        viewAllButton.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(bottomDividerView.snp.top).offset(-16)
        }
        
        bottomDividerView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.height.equalTo(8)
        }
    }
}

// MARK: - UICollectionViewDataSource

extension LatestCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stores.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: LatestStoreItemCell.identifier,
            for: indexPath
        ) as! LatestStoreItemCell
        cell.configure(with: stores[indexPath.item])
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension LatestCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180, height: 260)
    }
}

// MARK: - UICollectionViewDelegate

extension LatestCell: UICollectionViewDelegate {
    
}


class LatestStoreItemCell: UICollectionViewCell {
            
    private let storeImageView = UIImageView().then {
        $0.backgroundColor = .systemGray6
        $0.layer.cornerRadius = 8
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFill
    }
    
    private let recentOrderLabel = UILabel().then {
        $0.text = "최근 1번 주문한 가게"
        $0.font = .systemFont(ofSize: 12)
        $0.textColor = .systemBlue
    }
    
    private let storeNameLabel = UILabel().then {
        $0.font = .size12
        $0.textColor = .black
        $0.numberOfLines = 1
    }
    
    private let ratingLabel = UILabel().then {
        $0.font = .size12
        $0.textColor = .black
    }
    
    private let deliveryTimeImageView = UIImageView().then {
        $0.image = .image1
        $0.contentMode = .scaleAspectFit
        $0.tintColor = .systemBlue
    }

    private let deliveryTimeLabel = UILabel().then {
        $0.font = .size12
        $0.textColor = .systemBlue
    }

    private lazy var deliveryTimeStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 4
        $0.alignment = .center
        $0.addArrangedSubview(deliveryTimeImageView)
        $0.addArrangedSubview(deliveryTimeLabel)
    }
    
    private let deliveryFeeLabel = UILabel().then {
        $0.font = .size12
        $0.textColor = .systemBlue
    }
    
    private lazy var badgeStackView = UIStackView().then {
        $0.axis = .vertical  // 세로로 변경
        $0.spacing = 4
        $0.alignment = .leading
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.backgroundColor = .white
        
        contentView.addSubviews(
            storeImageView,
            recentOrderLabel,
            storeNameLabel,
            ratingLabel,
            deliveryTimeStackView,
            deliveryFeeLabel,
            badgeStackView
        )
        
        storeImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(140)
        }
        
        recentOrderLabel.snp.makeConstraints {
            $0.top.equalTo(storeImageView.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview()
        }
        
        storeNameLabel.snp.makeConstraints {
            $0.top.equalTo(recentOrderLabel.snp.bottom).offset(4)
            $0.leading.trailing.equalToSuperview()
        }
        
        ratingLabel.snp.makeConstraints {
            $0.top.equalTo(storeNameLabel.snp.bottom).offset(4)
            $0.leading.equalToSuperview()
        }
        
        deliveryTimeImageView.snp.makeConstraints {
            $0.width.height.equalTo(12)
        }

        deliveryTimeStackView.snp.makeConstraints {
            $0.top.equalTo(ratingLabel.snp.bottom).offset(4)
            $0.leading.equalToSuperview()
        }

        deliveryFeeLabel.snp.makeConstraints {
            $0.centerY.equalTo(deliveryTimeStackView)
            $0.leading.equalTo(deliveryTimeStackView.snp.trailing).offset(8)
        }
        
        badgeStackView.snp.makeConstraints {
            $0.top.equalTo(deliveryTimeStackView.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview()
        }
    }
    
    func configure(with store: Store) {
        storeNameLabel.text = store.storeName
        
        let reviewText = "(\(store.reviewCount))"
        ratingLabel.text = "⭐️ \(String(format: "%.1f", store.rating)) \(reviewText)"
        
        deliveryTimeLabel.text = "\(store.deliveryTime)"
        
        deliveryFeeLabel.text = "🚚 \(store.deliveryFee.displayText)"
        
        badgeStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        let badgeWidth = (180 - 8) / 3
        var currentRowStack: UIStackView?
        
        for (index, badge) in store.badges.enumerated() {
            if index % 2 == 0 {
                let rowStack = UIStackView()
                rowStack.axis = .horizontal
                rowStack.spacing = 4
                rowStack.alignment = .leading
                rowStack.distribution = .fillEqually
                badgeStackView.addArrangedSubview(rowStack)
                currentRowStack = rowStack
            }
            
            let badgeView = createBadgeView(text: badge.displayText, badge: badge, width: CGFloat(badgeWidth))
            currentRowStack?.addArrangedSubview(badgeView)
        }
        
        if store.badges.count % 2 == 1 {
            let spacer = UIView()
            currentRowStack?.addArrangedSubview(spacer)
        }
    }
    
    private func createBadgeView(text: String, badge: StoreBadge, width: CGFloat) -> UIView {
        let containerView = UIView()
        
        let isbaeminClub = (badge == .baeminClub)
        
        if isbaeminClub {
            containerView.backgroundColor = UIColor.systemTeal.withAlphaComponent(0.15)
            containerView.layer.borderColor = UIColor.systemTeal.cgColor
        } else {
            containerView.backgroundColor = UIColor.systemGray5.withAlphaComponent(0.5)
            containerView.layer.borderColor = UIColor.systemGray3.cgColor
        }
        
        containerView.layer.borderWidth = 0.5
        containerView.layer.cornerRadius = 3
        
        let label = UILabel()
        label.text = text
        label.font = .systemFont(ofSize: 9, weight: .medium)
        label.textColor = isbaeminClub ? .systemTeal : .darkGray
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.7
        
        containerView.snp.makeConstraints {
            $0.width.equalTo(width)
        }
        
        if isbaeminClub {
            let badgeImage = UIImageView(image: .image2)
            badgeImage.contentMode = .scaleAspectFit
            badgeImage.tintColor = .systemTeal
            
            containerView.addSubviews(badgeImage, label)
            
            badgeImage.snp.makeConstraints {
                $0.leading.equalToSuperview().inset(4)
                $0.centerY.equalToSuperview()
                $0.width.height.equalTo(10)
            }
            
            label.snp.makeConstraints {
                $0.leading.equalTo(badgeImage.snp.trailing).offset(2)
                $0.trailing.equalToSuperview().inset(4)
                $0.top.bottom.equalToSuperview().inset(3)
            }
        } else {
            containerView.addSubview(label)
            
            label.snp.makeConstraints {
                $0.leading.trailing.equalToSuperview().inset(6)
                $0.top.bottom.equalToSuperview().inset(3)
            }
        }
        
        return containerView
    }
}
