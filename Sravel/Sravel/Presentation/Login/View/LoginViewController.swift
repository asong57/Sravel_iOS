//
//  LoginViewController.swift
//  Sravel
//
//  Created by asong on 2022/05/16.
//

import UIKit
import SnapKit

final class LoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureSubViews()
        self.congifureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private lazy var loginLabel: UILabel = {
        let label = UILabel()
        label.text = "로그인"
        label.textColor = .darkBlue
        return label
    }()
    
    private lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = " 이메일 주소"
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = " 비밀번호"
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("로그인", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    private lazy var signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("회원가입", for: .normal)
        button.setTitleColor(.darkBlue, for: .normal)
        return button
    }()
}
extension LoginViewController{
    func configureSubViews() {
        self.view.addSubview(self.loginLabel)
        self.view.addSubview(self.emailTextField)
        self.view.addSubview(self.passwordTextField)
        self.view.addSubview(self.loginButton)
        self.view.addSubview(self.signUpButton)
    }
    
    func congifureUI(){
        self.loginLabel.snp.makeConstraints{ make in
            make.left.equalToSuperview().offset(50)
            make.bottom.equalTo(emailTextField.snp.top).offset(-60)
        }
        
        self.emailTextField.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(passwordTextField.snp.top).offset(-30)
            make.left.equalTo(self.view).offset(53)
            make.right.equalTo(self.view).offset(-53)
            make.height.equalTo(30)
        }
        
        self.passwordTextField.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(loginButton.snp.top).offset(-30)
            make.left.equalTo(self.view).offset(53)
            make.right.equalTo(self.view).offset(-53)
            make.height.equalTo(30)
        }
        
        self.loginButton.snp.makeConstraints{ make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(30)
        }
        
        self.signUpButton.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.top.equalTo(loginButton.snp.bottom).offset(20)
            make.width.equalTo(200)
            make.height.equalTo(30)
        }
    }
}
