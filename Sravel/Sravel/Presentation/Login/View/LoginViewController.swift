//
//  LoginViewController.swift
//  Sravel
//
//  Created by asong on 2022/05/16.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class LoginViewController: UIViewController {
    var viewModel: LoginViewModel?
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureSubViews()
        self.congifureUI()
        self.bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    static func create(with viewModel: LoginViewModel) -> LoginViewController{
        let view = LoginViewController()
        view.viewModel = viewModel
        return view
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
    
    private lazy var errorMessageLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textAlignment = .center
        label.text = ""
        return label
    }()
}
extension LoginViewController{
    func configureSubViews() {
        self.view.addSubview(self.loginLabel)
        self.view.addSubview(self.emailTextField)
        self.view.addSubview(self.passwordTextField)
        self.view.addSubview(self.loginButton)
        self.view.addSubview(self.signUpButton)
        self.view.addSubview(self.errorMessageLabel)
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
        self.errorMessageLabel.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.top.equalTo(signUpButton.snp.bottom).offset(20)
        }
    }
    
    func bindViewModel(){
        let input = LoginViewModel.Input(emailTextFieldDidEditEvent: emailTextField.rx.text.orEmpty.asObservable(), passwordTextFieldDidEditEvent: passwordTextField.rx.text.orEmpty.asObservable(), loginButtonDidTapEvent: self.loginButton.rx.tap.asObservable(), registerButtonDidTapEvent: signUpButton.rx.tap.asObservable())
        guard let viewModel = self.viewModel else{return}
        let output = viewModel.transform(from: input, disposeBag: self.disposeBag)
        self.bindErrorMessageLabel(output: output)
        self.bindLoginButton(output: output)
        self.moveToHomeViewController(output: output)
    }
    
    func bindErrorMessageLabel(output: LoginViewModel.Output?){
        output?.validationErrorMessage
            .asDriver()
            .drive(onNext: {[weak self] message in
                self?.errorMessageLabel.text = message
            }).disposed(by: disposeBag)
    }
    
    func bindLoginButton(output: LoginViewModel.Output?){
        output?.loginButtonShouldEnable
            .asDriver(onErrorJustReturn: false)
            .drive(onNext: { [weak self] isValid in
                self?.loginButton.isEnabled = isValid
                self?.loginButton.backgroundColor = isValid ? .blue : .lightBlue
            }).disposed(by: disposeBag)
    }
}
extension LoginViewController{
    func moveToHomeViewController(output: LoginViewModel.Output?){
        output?.isLoginSuccessed.asDriver(onErrorJustReturn: false)
            .drive(onNext: { [weak self] isValid in
                if isValid{
                    let homeVC = HomeViewController()
                    homeVC.view.backgroundColor = .white
                    self?.navigationController?.navigationBar.tintColor = .blue
                    self?.navigationController?.navigationBar.standardAppearance.titleTextAttributes = [.foregroundColor: UIColor.blue]
                    self?.navigationController!.pushViewController(homeVC, animated: true)
                }
            }).disposed(by: disposeBag)
    }
}
