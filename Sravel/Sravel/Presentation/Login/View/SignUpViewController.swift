//
//  SignUpViewController.swift
//  Sravel
//
//  Created by asong on 2022/05/26.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class SignUpViewController: UIViewController {
    var viewModel: SignUpViewModel?
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
    
    static func create(with viewModel: SignUpViewModel) -> SignUpViewController{
        let view = SignUpViewController()
        view.viewModel = viewModel
        return view
    }
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "회원가입"
        label.textColor = .darkBlue
        return label
    }()
    
    private lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = " 이름"
        return textField
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
    
    private lazy var passwordCheckTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = " 비밀번호 확인"
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private lazy var signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("회원가입", for: .normal)
        button.setTitleColor(.black, for: .normal)
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
extension SignUpViewController{
    func configureSubViews() {
        self.view.addSubview(self.nameTextField)
        self.view.addSubview(self.titleLabel)
        self.view.addSubview(self.emailTextField)
        self.view.addSubview(self.passwordTextField)
        self.view.addSubview(self.passwordCheckTextField)
        self.view.addSubview(self.signUpButton)
        self.view.addSubview(self.errorMessageLabel)
    }
    
    func congifureUI(){
        self.titleLabel.snp.makeConstraints{ make in
            make.left.equalToSuperview().offset(50)
            make.bottom.equalTo(nameTextField.snp.top).offset(-60)
        }
        
        self.nameTextField.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(emailTextField.snp.top).offset(-30)
            make.left.equalTo(self.view).offset(53)
            make.right.equalTo(self.view).offset(-53)
            make.height.equalTo(30)
        }
        
        self.emailTextField.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(passwordTextField.snp.top).offset(-30)
            make.left.equalTo(self.view).offset(53)
            make.right.equalTo(self.view).offset(-53)
            make.height.equalTo(30)
        }
        
        self.passwordTextField.snp.makeConstraints{ make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
            make.left.equalTo(self.view).offset(53)
            make.right.equalTo(self.view).offset(-53)
            make.height.equalTo(30)
        }
        
        self.passwordCheckTextField.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.top.equalTo(passwordTextField.snp.bottom).offset(30)
            make.left.equalTo(self.view).offset(53)
            make.right.equalTo(self.view).offset(-53)
            make.height.equalTo(30)
        }
        
        self.signUpButton.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.top.equalTo(passwordCheckTextField.snp.bottom).offset(30)
            make.width.equalTo(200)
            make.height.equalTo(30)
        }
        self.errorMessageLabel.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.top.equalTo(signUpButton.snp.bottom).offset(20)
        }
    }
    
    func bindViewModel(){
        let input = SignUpViewModel.Input(nameTextFieldDidEditEvent: nameTextField.rx.text.orEmpty.asObservable(), emailTextFieldDidEditEvent: emailTextField.rx.text.orEmpty.asObservable(), passwordTextFieldDidEditEvent: passwordTextField.rx.text.orEmpty.asObservable(), passwordForCheckTextFieldDidEditEvent: passwordCheckTextField.rx.text.orEmpty.asObservable(), registerButtonDidTapEvent: signUpButton.rx.tap.asObservable())
        guard let viewModel = self.viewModel else{return}
        let output = viewModel.transform(from: input, disposeBag: self.disposeBag)
        self.bindErrorMessageLabel(output: output)
        self.bindLoginButton(output: output)
    }
    
    func bindErrorMessageLabel(output: SignUpViewModel.Output?){
        output?.validationErrorMessage
            .asDriver()
            .drive(onNext: {[weak self] message in
                self?.errorMessageLabel.text = message
            }).disposed(by: disposeBag)
    }
    
    func bindLoginButton(output: SignUpViewModel.Output?){
        output?.registerButtonShouldEnable
            .asDriver(onErrorJustReturn: false)
            .drive(onNext: { [weak self] isValid in
                self?.signUpButton.isEnabled = isValid
                self?.signUpButton.backgroundColor = isValid ? .blue : .lightBlue
            }).disposed(by: disposeBag)
    }
}
