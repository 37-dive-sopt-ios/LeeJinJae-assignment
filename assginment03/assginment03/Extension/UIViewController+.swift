//
//  UIViewController.swift
//  baemin03
//
//  Created by JIN on 11/12/25.
//


import UIKit

extension UIViewController {
    
    func changeRootViewController(_ viewController: UIViewController, animated: Bool = true) {
        guard let window = UIApplication.shared.connectedScenes
            .compactMap({ $0 as? UIWindowScene })
            .flatMap({ $0.windows })
            .first(where: { $0.isKeyWindow }) else {
            return
        }
        
        window.rootViewController = viewController
        
        if animated {
            UIView.transition(
                with: window,
                duration: 0.3,
                options: .transitionCrossDissolve,
                animations: nil,
                completion: nil
            )
        }
    }
    
    func moveToMainTab() {
        let mainTabView = MainViewController()
        changeRootViewController(mainTabView)
    }
    

    func moveToWelcomeVC() {
        let welcomeVC = WelcomeViewController()
        let nav = UINavigationController(rootViewController: welcomeVC)
        changeRootViewController(nav)
    }
}
