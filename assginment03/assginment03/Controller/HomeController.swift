//
//  HomeController.swift
//  baemin03
//
//  Created by JIN on 11/10/25.
//

import UIKit
import SnapKit
import Then


enum Section: Int, CaseIterable {
    case banner
    case categoryTab
    case foodCategory
    case moreButton
    case brandList
    case bottomBanner
    case ranking
    case latest
    case dicount
}

class HomeController: UIViewController {
    
    // MARK: - Properties
    
    private let categories = ["음식배달", "픽업", "장보기·쇼핑", "선물하기", "혜택모아"]
    private var categoryViewControllers: [CategoryContentViewController] = []
    private var currentCategoryIndex = 0
    
    // MARK: - UI Components
    
    private let headerView = HomeHeaderView()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectViewInset: UIEdgeInsets = .init(top: 6, left: 0, bottom: 6, right: 0)
        layout.sectionInset = collectViewInset
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.delegate = self
        cv.dataSource = self
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        cv.contentInsetAdjustmentBehavior = .never
        cv.alwaysBounceVertical = true
        return cv
    }()
    
    private lazy var pageViewController: UIPageViewController = {
        let pvc = UIPageViewController(transitionStyle: .scroll,
                                      navigationOrientation: .horizontal,
                                      options: nil)
        pvc.delegate = self
        pvc.dataSource = self
        return pvc
    }()
    
    private var pageContainerCell: FoodCategoryContainerCell?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        registerCells()
        setupPageViewController()
    }
    
    // MARK: - UI Setup
    
    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubviews(headerView, collectionView)
        
        headerView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(160)
        }
     
        collectionView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func registerCells() {
        collectionView.register(BannerCell.self, forCellWithReuseIdentifier: BannerCell.identifier)
        collectionView.register(CategoryTabCell.self, forCellWithReuseIdentifier: CategoryTabCell.identifier)
        collectionView.register(FoodCategoryContainerCell.self, forCellWithReuseIdentifier: FoodCategoryContainerCell.identifier)
        collectionView.register(MoreButtonCell.self, forCellWithReuseIdentifier: MoreButtonCell.identifier)
        collectionView.register(BrandListCell.self, forCellWithReuseIdentifier: BrandListCell.identifier)
        collectionView.register(BottomBannerCell.self, forCellWithReuseIdentifier: BottomBannerCell.identifier)
        collectionView.register(RankingCell.self, forCellWithReuseIdentifier: RankingCell.identifier)
        collectionView.register(LatestCell.self, forCellWithReuseIdentifier: LatestCell.identifier)
        collectionView.register(DiscountCell.self, forCellWithReuseIdentifier: DiscountCell.identifier)
    }
    
    private func setupPageViewController() {
        categoryViewControllers = categories.enumerated().map { index, category in
            let vc = CategoryContentViewController()
            vc.categoryIndex = index
            vc.categoryName = category
            return vc
        }
        
        addChild(pageViewController)
        pageViewController.didMove(toParent: self)
        
        if let firstVC = categoryViewControllers.first {
            pageViewController.setViewControllers([firstVC],
                                                 direction: .forward,
                                                 animated: false,
                                                 completion: nil)
        }
    }
    
    // MARK: - Helper Methods
    
    private func movePage(to index: Int, animated: Bool = true) {
        guard index != currentCategoryIndex,
              index >= 0,
              index < categoryViewControllers.count else { return }
        
        let direction: UIPageViewController.NavigationDirection = index > currentCategoryIndex ? .forward : .reverse
        currentCategoryIndex = index
        
        pageViewController.setViewControllers([categoryViewControllers[index]],
                                             direction: direction,
                                             animated: animated,
                                             completion: nil)
    }
}

// MARK: - UICollectionViewDataSource

extension HomeController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Section.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let section = Section(rawValue: indexPath.section) else {
            return UICollectionViewCell()
        }
        
        switch section {
        case .banner:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: BannerCell.identifier,
                for: indexPath
            ) as! BannerCell
            return cell
            
        case .categoryTab:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CategoryTabCell.identifier,
                for: indexPath
            ) as! CategoryTabCell
            
            cell.onTabSelected = { [weak self] index in
                self?.movePage(to: index)
            }
            return cell
            
        case .foodCategory:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: FoodCategoryContainerCell.identifier,
                for: indexPath
            ) as! FoodCategoryContainerCell
            
            if pageContainerCell == nil {
                pageContainerCell = cell
                cell.contentView.addSubview(pageViewController.view)
                pageViewController.view.snp.makeConstraints {
                    $0.edges.equalToSuperview()
                }
            }
            return cell
            
        case .moreButton:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: MoreButtonCell.identifier,
                for: indexPath
            ) as! MoreButtonCell
            return cell
            
        case .brandList:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: BrandListCell.identifier,
                for: indexPath
            ) as! BrandListCell
            return cell
            
        case .bottomBanner:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: BottomBannerCell.identifier,
                for: indexPath
            ) as! BottomBannerCell
            return cell
            
        case .ranking:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: RankingCell.identifier,
                for: indexPath
            ) as! RankingCell
            return cell
            
        case .latest:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: LatestCell.identifier,
                for: indexPath
            ) as! LatestCell
            return cell
            
        case .dicount:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: DiscountCell.identifier,
                for: indexPath
            ) as! DiscountCell
            return cell
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension HomeController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let section = Section(rawValue: indexPath.section) else {
            return .zero
        }
        
        let width = collectionView.frame.width
        
        switch section {
        case .banner:
            return CGSize(width: width, height: 112)
            
        case .categoryTab:
            return CGSize(width: width, height: 50)
            
        case .foodCategory:
            return CGSize(width: width, height: 180)
            
        case .moreButton:
            return CGSize(width: width, height: 50)
            
        case .brandList:
            return CGSize(width: width, height: 100)
            
        case .bottomBanner:
            return CGSize(width: width, height: 200)
            
        case .ranking:
            return CGSize(width: width, height: 330)
            
        case .latest:
            return CGSize(width: width, height: 330)
            
        case .dicount:
            return CGSize(width: width, height: 400)
        }
    }
}

// MARK: - UIPageViewControllerDelegate & DataSource

extension HomeController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController,
                           viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let vc = viewController as? CategoryContentViewController,
              let index = categoryViewControllers.firstIndex(of: vc),
              index > 0 else { return nil }
        return categoryViewControllers[index - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                           viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let vc = viewController as? CategoryContentViewController,
              let index = categoryViewControllers.firstIndex(of: vc),
              index < categoryViewControllers.count - 1 else { return nil }
        return categoryViewControllers[index + 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                           didFinishAnimating finished: Bool,
                           previousViewControllers: [UIViewController],
                           transitionCompleted completed: Bool) {
        if completed,
           let currentVC = pageViewController.viewControllers?.first as? CategoryContentViewController,
           let index = categoryViewControllers.firstIndex(of: currentVC) {
            currentCategoryIndex = index
            
            // 탭 업데이트
            if let cell = collectionView.cellForItem(at: IndexPath(row: 0, section: Section.categoryTab.rawValue)) as? CategoryTabCell {
                cell.updateSelectedTab(index: index)
            }
        }
    }
}

#Preview {
   HomeController()
}
