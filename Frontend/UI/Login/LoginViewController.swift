//
//  LoginViewController.swift
//  Frontend
//
//  Created by Suyeon Hwang on 11/2/24.
//

import UIKit
import SnapKit

final class LoginViewController: UIViewController {
    
    // MARK: - Properties
    
    // MARK: - Views
    
    private let logoImageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    private let emailTextField: CustomTextField = {
        let tf = CustomTextField()
        tf.placeholder = "이메일을 입력해주세요."
        tf.addTarget(self, action: #selector(tfDidChange), for: .editingChanged)
        return tf
    }()
    
    private let passwordTextField: CustomTextField = {
        let tf = CustomTextField()
        tf.placeholder = "비밀번호를 입력해주세요."
        tf.isSecureTextEntry = true
        tf.addTarget(self, action: #selector(tfDidChange), for: .editingChanged)
        return tf
    }()
    
    private let loginButton: NextButton = {
        let button = NextButton()
        button.addTarget(self, action: #selector(loginButtonDidTap), for: .touchUpInside)
        return button
    }()
    
    private let borderLine1: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        return view
    }()
    
    private let ifYouDontHaveAccountLabel: UILabel = {
        let label = UILabel()
        label.text = "계정이 없다면?"
        label.textColor = .darkGray
        label.font = .Pretendard(family: .Medium)
        return label
    }()
    
    private let borderLine2: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        return view
    }()
    
    private let signupButton: NextButton = {
        let button = NextButton(title: "회원가입")
        button.isActive = true
        button.addTarget(self, action: #selector(signupButtonDidTap), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupLogoImageView()
        setupEmailTextField()
        setupPasswordTextField()
        setupLoginButton()
        setupIfYouDontHaveAccountLabelAndLines()
        setupSignupButton()
    }
    
    // MARK: - Layout
    
    private func setupLogoImageView() {
        view.addSubview(logoImageView)
        
        logoImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(160)
            make.width.equalTo(logoImageView.snp.height).multipliedBy(1)
            make.top.equalToSuperview().inset(145)
        }
    }
    
    private func setupEmailTextField() {
        view.addSubview(emailTextField)
        
        emailTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(40)
            make.top.equalTo(logoImageView.snp.bottom).offset(70)
            make.height.equalTo(42)
        }
    }
    
    private func setupPasswordTextField() {
        view.addSubview(passwordTextField)
        
        passwordTextField.snp.makeConstraints { make in
            make.leading.trailing.equalTo(emailTextField)
            make.top.equalTo(emailTextField.snp.bottom).offset(15)
            make.height.equalTo(42)
        }
    }
    
    private func setupLoginButton() {
        view.addSubview(loginButton)
        
        loginButton.snp.makeConstraints { make in
            make.leading.trailing.equalTo(passwordTextField)
            make.top.equalTo(passwordTextField.snp.bottom).offset(24)
        }
    }
    
    private func setupIfYouDontHaveAccountLabelAndLines() {
        view.addSubview(borderLine1)
        view.addSubview(ifYouDontHaveAccountLabel)
        view.addSubview(borderLine2)
        
        borderLine1.snp.makeConstraints { make in
            make.leading.equalTo(loginButton.snp.leading)
            make.height.equalTo(1)
            make.centerY.equalTo(ifYouDontHaveAccountLabel.snp.centerY)
            make.trailing.equalTo(ifYouDontHaveAccountLabel.snp.leading).offset(-20)
        }
        
        ifYouDontHaveAccountLabel.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(49)
            make.centerX.equalToSuperview()
        }
        
        borderLine2.snp.makeConstraints { make in
            make.leading.equalTo(ifYouDontHaveAccountLabel.snp.trailing).offset(20)
            make.height.equalTo(1)
            make.centerY.equalTo(ifYouDontHaveAccountLabel.snp.centerY)
            make.trailing.equalTo(loginButton.snp.trailing)
        }
    }
    
    private func setupSignupButton() {
        view.addSubview(signupButton)
        
        signupButton.snp.makeConstraints { make in
            make.leading.trailing.equalTo(loginButton)
            make.top.equalTo(ifYouDontHaveAccountLabel.snp.bottom).offset(17)
        }
    }
    
    // MARK: - Actions
    
    @objc private func tfDidChange(_ sender: UITextField) {
        let emailText = emailTextField.text
        let passwordText = passwordTextField.text
        print("email: \(emailText), password:\(passwordText)")
        
        if emailText != "" && passwordText != "" {
            loginButton.isActive = true
        }
        else {
            loginButton.isActive = false
        }
    }
    
    @objc private func loginButtonDidTap() {
        print("login button tapped")
        
        let email = emailTextField.text
        let password = passwordTextField.text
        
        let request = LoginRequestDTO(userId: email!, password: password!)
        
        LoginService.postLogin(request: request) { [weak self] succeed, failed in
            guard let data = succeed else {
                // 에러가 난 경우, alert 창 present
                switch failed {
                case .disconnected:
                    self?.present(UIAlertController.networkErrorAlert(title: failed!.localizedDescription), animated: true)
                default:
                    self?.present(UIAlertController.networkErrorAlert(title: "로그인에 실패하였습니다."), animated: true)
                }
                return
            }
            
            print("=== LoginVC, loginButtonDidTap succeeded ===")
            print("== data: \(data)")
            
            // 만약 실패한 경우 실패했다고 알림창
            UserDefaults.standard.set(true, forKey: "isFirstLaunch")
            UserDefaults.standard.synchronize()
            
            UserDefaultsManager.shared.setData(value: data.id, key: .id)
            UserDefaultsManager.shared.setData(value: data.uuid, key: .uuid)
            UserDefaultsManager.shared.setData(value: data.age, key: .age)
            UserDefaultsManager.shared.setData(value: data.keyword1 ?? "", key: .keyword1)
            UserDefaultsManager.shared.setData(value: data.keyword2 ?? "", key: .keyword2)
            UserDefaultsManager.shared.setData(value: data.keyword3 ?? "", key: .keyword3)
            
            self?.moveToHomeVC()
        }
    }
    
    @objc private func signupButtonDidTap() {
        print("signup button tapped")
        
        // 프로필 설정 창 올리기
        let signupVC = SignupViewController()
        signupVC.modalPresentationStyle = .fullScreen
        self.present(signupVC, animated: true)
//        if let loginVC = self.navigationController?.topViewController as? LoginVC {
//            loginVC.present(newUserProfileVC, animated: true)
//        }
    }
    
    // MARK: - Functions
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    private func moveToHomeVC() {
        DispatchQueue.main.async {
            (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootVcTo(TabBarViewController(), animated: false)
        }
    }
}

#Preview {
    LoginViewController()
}
