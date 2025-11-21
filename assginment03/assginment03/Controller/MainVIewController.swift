//
//  MainVIewController.swift
//  baemin03
//
//  Created by JIN on 11/10/25.
//


import UIKit

final class MainViewController: UITabBarController {

    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
}

   // MARK: - UI & Layout

extension MainViewController {
    
    private func setUp() {
        setUpTabBar()
        configureViewControllers()
    }
    
    func setUpTabBar() {
        tabBar.tintColor = .black
    }
    
    func configureViewControllers() {
        
        let home = navigationControllerWrapper(tabBarImage: .home, rootViewController: HomeController())
        let shopping = navigationControllerWrapper(tabBarImage: .bag, rootViewController: LoginViewController_Network())
        let save = navigationControllerWrapper(tabBarImage: .paper, rootViewController: SaveController())
        let history = navigationControllerWrapper(tabBarImage: .bag, rootViewController: HistoryController())
        let myPage = navigationControllerWrapper(tabBarImage: .mybaemin, rootViewController: MyPageController())
        viewControllers = [
            home, shopping, save, history, myPage
        ]
    }

    func navigationControllerWrapper(tabBarImage: UIImage, rootViewController: UIViewController) -> UIViewController {
        
        let navigationController = UINavigationController(rootViewController: rootViewController)
        navigationController.tabBarItem.image = tabBarImage
        navigationController.tabBarItem.selectedImage = tabBarImage
        return navigationController
    }
}

#Preview {
    MainViewController()
}
