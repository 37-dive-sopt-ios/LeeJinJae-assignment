//
//
//


import UIKit
import SnapKit

final class LoginViewController_Network: BaseViewController {
    
    // MARK: - UI Components

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = true
        return scrollView
    }()

    private let contentView: UIView = {
        let view = UIView()
        return view
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "4차 세미나"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 2
        label.textColor = .black
        return label
    }()
    
    private let usernameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Username (예: johndoe)"
        textField.borderStyle = .roundedRect
        textField.autocapitalizationType = .none
        textField.text = "JJ"
        textField.addPadding()
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password (예: P@ssw0rd!)"
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        textField.text = "Aa1234!@"
        textField.addPadding()
        return textField
    }()
    
    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "이름 (예: 이진재)"
        textField.borderStyle = .roundedRect
        textField.text = "이진재"
        textField.addPadding()
        return textField
    }()
    
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email (예: hong@example.com)"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .emailAddress
        textField.autocapitalizationType = .none
        textField.text = "Jin@naver.com"
        textField.addPadding()
        return textField
    }()
    
    private let ageTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "나이 (예: 25)"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .numberPad
        textField.text = "25"  
        textField.addPadding()
        return textField
    }()
    
    private lazy var registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("회원가입 (POST /api/v1/users)", for: .normal)
        button.backgroundColor = .orange
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("로그인 (POST /api/v1/auth/login)", for: .normal)
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("로그아웃", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var withdrawButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("회원탈퇴", for: .normal)
        button.backgroundColor = .systemRed
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(withdrawButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var updateInfoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("회원정보 수정", for: .normal)
        button.backgroundColor = .systemPurple
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(updateInfoButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var getUserButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("개인정보 조회", for: .normal)
        button.backgroundColor = .systemOrange
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(getUserButtonTapped), for: .touchUpInside)
        return button
    }()

    // MARK: - Properties

    private let provider: NetworkProviding
    private var currentUserId: Int?
    
    // MARK: - Init
    
    init(provider: NetworkProviding = NetworkProvider()) {
        self.provider = provider
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setHierarchy()
        setLayout()
    }
    
    // MARK: - UI & Layout
    
    private func setHierarchy() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubviews(
            titleLabel,
            usernameTextField,
            passwordTextField,
            nameTextField,
            emailTextField,
            ageTextField,
            registerButton,
            loginButton,
            logoutButton,
            withdrawButton,
            updateInfoButton,
            getUserButton
        )
    }
    
    private func setLayout() {
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }

        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalTo(scrollView.frameLayoutGuide)
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(25)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        
        usernameTextField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(40)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(50)
        }
        
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(usernameTextField.snp.bottom).offset(12)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(50)
        }
        
        nameTextField.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(12)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(50)
        }
        
        emailTextField.snp.makeConstraints {
            $0.top.equalTo(nameTextField.snp.bottom).offset(12)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(50)
        }
        
        ageTextField.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).offset(12)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(50)
        }
        
        registerButton.snp.makeConstraints {
            $0.top.equalTo(ageTextField.snp.bottom).offset(30)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(55)
        }
        
        loginButton.snp.makeConstraints {
            $0.top.equalTo(registerButton.snp.bottom).offset(12)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(55)
        }

        logoutButton.snp.makeConstraints {
            $0.top.equalTo(loginButton.snp.bottom).offset(12)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(55)
        }

        withdrawButton.snp.makeConstraints {
            $0.top.equalTo(logoutButton.snp.bottom).offset(12)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(55)
        }

        updateInfoButton.snp.makeConstraints {
            $0.top.equalTo(withdrawButton.snp.bottom).offset(12)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(55)
        }

        getUserButton.snp.makeConstraints {
            $0.top.equalTo(updateInfoButton.snp.bottom).offset(12)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(55)
            $0.bottom.equalToSuperview().inset(30)
        }
    }
    
    // MARK: - Actions
    
    @objc private func registerButtonTapped() {
        guard let username = usernameTextField.text, !username.isEmpty,
              let password = passwordTextField.text, !password.isEmpty,
              let name = nameTextField.text, !name.isEmpty,
              let email = emailTextField.text, !email.isEmpty,
              let ageText = ageTextField.text, let age = Int(ageText) else {
            showAlert(title: "입력 오류", message: "모든 필드를 올바르게 입력해주세요.")
            return
        }
        
        Task {
            await performRegister(
                username: username,
                password: password,
                name: name,
                email: email,
                age: age
            )
        }
    }
    
    @objc private func loginButtonTapped() {
        guard let username = usernameTextField.text, !username.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            showAlert(title: "입력 오류", message: "아이디와 비밀번호를 입력해주세요.")
            return
        }

        Task {
            await performLogin(username: username, password: password)
        }
    }

    @objc private func logoutButtonTapped() {
        Task {
            await performLogout()
        }
    }

    @objc private func withdrawButtonTapped() {
        guard let userId = currentUserId else {
            showAlert(title: "회원탈퇴 실패", message: "먼저 로그인해주세요.")
            return
        }

        Task {
            await performDeleteUser(id: userId)
        }
    }

    @objc private func updateInfoButtonTapped() {
        guard let userId = currentUserId else {
            showAlert(title: "회원정보 수정 실패", message: "먼저 로그인해주세요.")
            return
        }

        guard let name = nameTextField.text,
              let email = emailTextField.text,
              let ageText = ageTextField.text, let age = Int(ageText) else {
            showAlert(title: "입력 오류", message: "수정할 정보를 입력해주세요.")
            return
        }

        Task {
            await performUpdateUser(id: userId, name: name, email: email, age: age)
        }
    }

    @objc private func getUserButtonTapped() {
        guard let userId = currentUserId else {
            showAlert(title: "개인정보 조회 실패", message: "먼저 로그인해주세요.")
            return
        }

        Task {
            await performGetUser(id: userId)
        }
    }

    // MARK: - Network Methods (Swift Concurrency!)
    
    @MainActor
    private func performRegister(
        username: String,
        password: String,
        name: String,
        email: String,
        age: Int
    ) async {
        loadingIndicator.startAnimating()
        
        do {
            let response = try await UserAPI.performRegister(
                username: username,
                password: password,
                name: name,
                email: email,
                age: age,
                provider: provider
            )
            
            showAlert(title: "회원가입 성공", message: "회원가입이 완료되었습니다!") { [weak self] in
                self?.navigateToWelcome(userId: response.id, userName: response.name)
            }
        } catch let error as NetworkError {
            print("🚨 [Register Error] \(error.detailedDescription)")
            showAlert(title: "회원가입 실패", message: error.localizedDescription)
        } catch {
            print("🚨 [Register Unknown Error] \(error)")
            showAlert(title: "회원가입 실패", message: error.localizedDescription)
        }
        
        loadingIndicator.stopAnimating()
    }
    
    @MainActor
    private func performLogin(username: String, password: String) async {
        loadingIndicator.startAnimating()

        do {
            let response = try await UserAPI.performLogin(
                username: username,
                password: password,
                provider: provider
            )

            currentUserId = response.userId

            showAlert(title: "로그인 성공", message: response.message)
        } catch let error as NetworkError {
            print("🚨 [Login Error] \(error.detailedDescription)")
            showAlert(title: "로그인 실패", message: error.localizedDescription)
        } catch {
            print("🚨 [Login Unknown Error] \(error)")
            showAlert(title: "로그인 실패", message: error.localizedDescription)
        }

        loadingIndicator.stopAnimating()
    }

    @MainActor
    private func performLogout() async {
        currentUserId = nil
        usernameTextField.text = ""
        passwordTextField.text = ""

        showAlert(title: "로그아웃 성공", message: "로그아웃되었습니다.")
    }

    @MainActor
    private func performDeleteUser(id: Int) async {
        loadingIndicator.startAnimating()

        do {
            let message = try await UserAPI.performDeleteUser(id: id, provider: provider)

            currentUserId = nil
            usernameTextField.text = ""
            passwordTextField.text = ""
            nameTextField.text = ""
            emailTextField.text = ""
            ageTextField.text = ""

            showAlert(title: "회원탈퇴 성공", message: message)
        } catch let error as NetworkError {
            print("🚨 [Delete User Error] \(error.detailedDescription)")
            showAlert(title: "회원탈퇴 실패", message: error.localizedDescription)
        } catch {
            print("🚨 [Delete User Unknown Error] \(error)")
            showAlert(title: "회원탈퇴 실패", message: error.localizedDescription)
        }

        loadingIndicator.stopAnimating()
    }

    @MainActor
    private func performUpdateUser(id: Int, name: String, email: String, age: Int) async {
        loadingIndicator.startAnimating()

        do {
            let response = try await UserAPI.performUpdateUser(
                id: id,
                name: name,
                email: email,
                age: age,
                provider: provider
            )

            showAlert(title: "회원정보 수정 성공", message: "회원정보가 성공적으로 수정되었습니다.\n이름: \(response.name)\n이메일: \(response.email)\n나이: \(response.age)")
        } catch let error as NetworkError {
            print("🚨 [Update User Error] \(error.detailedDescription)")
            showAlert(title: "회원정보 수정 실패", message: error.localizedDescription)
        } catch {
            print("🚨 [Update User Unknown Error] \(error)")
            showAlert(title: "회원정보 수정 실패", message: error.localizedDescription)
        }

        loadingIndicator.stopAnimating()
    }

    @MainActor
    private func performGetUser(id: Int) async {
        loadingIndicator.startAnimating()

        do {
            let response = try await UserAPI.performGetUser(id: id, provider: provider)

            showAlert(
                title: "개인정보 조회 성공",
                message: """
                ID: \(response.id)
                Username: \(response.username)
                이름: \(response.name)
                이메일: \(response.email)
                나이: \(response.age)
                상태: \(response.status)
                """
            )
        } catch let error as NetworkError {
            print("🚨 [Get User Error] \(error.detailedDescription)")
            showAlert(title: "개인정보 조회 실패", message: error.localizedDescription)
        } catch {
            print("🚨 [Get User Unknown Error] \(error)")
            showAlert(title: "개인정보 조회 실패", message: error.localizedDescription)
        }

        loadingIndicator.stopAnimating()
    }

    // MARK: - Navigation
    
    private func navigateToWelcome(userId: Int, userName: String) {
        let welcomeVC = WelcomeViewController_Network()
        navigationController?.pushViewController(welcomeVC, animated: true)
    }
}

#Preview {
    LoginViewController_Network()
}
