//
//  CategoryContentViewController.swift
//  assginment03
//
//  Created by JIN on 11/14/25.
//

import UIKit
import SnapKit
import Then

class CategoryContentViewController: UIViewController {
    
    // MARK: - Properties
    
    var categoryIndex: Int = 0
    var categoryName: String = ""
    
    // MARK: - UI Components
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 8, left: 20, bottom: 0, right: 20)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 6  // 세로 간격 12
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.dataSource = self
        cv.delegate = self
        cv.showsHorizontalScrollIndicator = false
        cv.showsVerticalScrollIndicator = false
        cv.isScrollEnabled = false
        cv.register(FoodItemCell.self, forCellWithReuseIdentifier: FoodItemCell.identifier)
        return cv
    }()
    
    // MARK: - Data
    
    private var foodItems: [FoodItem] = []
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
    }
    
    // MARK: - Setup
    
    private func setupUI() {
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func loadData() {
        switch categoryIndex {
        case 0: // 음식배달 - 2줄 10개 (5개씩)
            view.backgroundColor = .white
            collectionView.backgroundColor = .white
            foodItems = [
                FoodItem(title: "한국음식", imageName: "korean"),
                FoodItem(title: "치킨", imageName: "chicken"),
                FoodItem(title: "카페/디저트", imageName: "cafe"),
                FoodItem(title: "피자", imageName: "pizza"),
                FoodItem(title: "분식", imageName: "snack"),
                FoodItem(title: "고기", imageName: "meat"),
                FoodItem(title: "찜·탕", imageName: "stew"),
                FoodItem(title: "야식", imageName: "latenight"),
                FoodItem(title: "패스트푸드", imageName: "fastfood"),
                FoodItem(title: "편의점", imageName: "convenience")
            ]
            collectionView.isHidden = false
            
        case 1: // 픽업
            view.backgroundColor = UIColor(red: 0.95, green: 0.97, blue: 1.0, alpha: 1.0)
            collectionView.isHidden = true
            
        case 2: // 장보기·쇼핑
            view.backgroundColor = UIColor(red: 0.95, green: 1.0, blue: 0.95, alpha: 1.0)
            collectionView.isHidden = true
            
        case 3: // 선물하기
            view.backgroundColor = UIColor(red: 1.0, green: 0.95, blue: 0.97, alpha: 1.0)
            collectionView.isHidden = true
            
        case 4: // 혜택모아
            view.backgroundColor = UIColor(red: 1.0, green: 0.98, blue: 0.93, alpha: 1.0)
            collectionView.isHidden = true
            
        default:
            view.backgroundColor = .white
            collectionView.isHidden = true
        }
        
        collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDataSource

extension CategoryContentViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return foodItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: FoodItemCell.identifier,
            for: indexPath
        ) as! FoodItemCell
        
        cell.configure(with: foodItems[indexPath.item])
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension CategoryContentViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 한 줄에 5개씩 배치
        let screenWidth = UIScreen.main.bounds.width
        let horizontalPadding: CGFloat = 40  // 좌우 패딩 (20 * 2)
        let availableWidth = screenWidth - horizontalPadding
        let itemWidth = availableWidth / 5
        
        // 높이 줄임
        return CGSize(width: itemWidth, height: 90)
    }
}
