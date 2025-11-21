//
//  WelcomeViewController.swift
//  sopt-37th-02Seminar
//
//  Created by JIN on 10/26/25.
//

import UIKit
import SnapKit
import Then

final class WelcomeViewController: UIViewController {
    
    // MARK: - Properties
    
    var name: String?
    
    // MARK: - UI Components
    
    private let backButton = UIButton(type: .system).then {
        $0.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        $0.tintColor = .black
    }
    
    private let titleLabel = UILabel().then {
        $0.text = "대체 뼈찜 누가 시켰어??"
        $0.font = .size17
        $0.textColor = .black
        $0.textAlignment = .center
    }
    
    private let baeminImage = UIImageView().then {
        $0.image = .배민이미지
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
    }
    
    private let welcomeLabel = UILabel().then {
        $0.text = "환영합니다"
        $0.font = .size24
        $0.textColor = .black
        $0.textAlignment = .center
    }
    
    private let welcomeNewMember = UILabel().then {
        $0.text = "○○님 반가워요!"
        $0.font = .size17
        $0.textColor = .black
        $0.textAlignment = .center
    }
    
    private lazy var pushMainButton = UIButton(type: .system).then {
        $0.setTitle("메인으로 가기", for: .normal)
        $0.titleLabel?.font = .size17
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = UIColor(named: "baemin_mint") ?? .systemTeal
        $0.layer.cornerRadius = 8
        $0.addTarget(self, action: #selector(pushMainViewController), for: .touchUpInside)
    }
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setLayout()
        setupNavigationBar()
    }
    
    // MARK: - Setup
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: - Component Action
    
    @objc
    private func pushMainViewController() {
        moveToMainTab()
    }
}

// MARK: - UI & Layout

extension WelcomeViewController {
    
    func configureUI() {
        view.backgroundColor = .white
        view.addSubviews(backButton, titleLabel, baeminImage, welcomeLabel, welcomeNewMember, pushMainButton)
    }
    
    func setLayout() {
        backButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(8)
            $0.leading.equalToSuperview().offset(20)
            $0.width.height.equalTo(44)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerY.equalTo(backButton)
            $0.centerX.equalToSuperview()
        }
        
        baeminImage.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(40)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(baeminImage.snp.width).multipliedBy(0.6)
        }
        
        welcomeLabel.snp.makeConstraints {
            $0.top.equalTo(baeminImage.snp.bottom).offset(50)
            $0.centerX.equalToSuperview()
        }
        
        welcomeNewMember.snp.makeConstraints {
            $0.top.equalTo(welcomeLabel.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
        }
        
        pushMainButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(30)
            $0.height.equalTo(56)
        }
    }
}
