//
//  PlusSnapshotViewController.swift
//  Sravel
//
//  Created by asong on 2022/06/26.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class PlusSnapshotViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureSubViews()
        self.congifureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "여행지 등록"
    }
    private lazy var locationSelectionButton: UIButton = {
        let button = UIButton()
        button.setTitle("위치를 선택해주세요.", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        //button.setBackgroundImage(UIImage(named: "box_join"), for: .normal)
        return button
    }()
    
    private lazy var cameraButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "camera"), for: .normal)
        return button
    }()
    
    private lazy var albumButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "gallery"), for: .normal)
        return button
    }()
    
    private lazy var snapshotImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "plus_photo")
        return imageView
    }()
    
    private lazy var titleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = " 제목"
        textField.background = UIImage(named: "box_join")
        return textField
    }()
    
    private lazy var contentTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = " 내용"
        textField.background = UIImage(named: "box_join")
        return textField
    }()
    
    private lazy var hashtagTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = " 해시태그"
        textField.background = UIImage(named: "box_join")
        return textField
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 10.0
        stack.alignment = .fill
        stack.distribution = .fill
        [self.cameraButton, self.albumButton].forEach { stack.addArrangedSubview($0) }
        return stack
    }()
    
    private lazy var registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("등록", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .darkBlue
        return button
    }()
}
extension PlusSnapshotViewController{
    func configureSubViews() {
        self.view.addSubview(locationSelectionButton)
        self.view.addSubview(snapshotImageView)
        self.view.addSubview(titleTextField)
        self.view.addSubview(hashtagTextField)
        self.view.addSubview(stackView)
        self.view.addSubview(contentTextField)
        self.view.addSubview(registerButton)
    }
    
    func congifureUI(){
        locationSelectionButton.snp.makeConstraints{ make in
            make.top.equalTo(self.view).offset(100)
            make.centerX.equalToSuperview()
        }
        
        cameraButton.snp.makeConstraints{ make in
            make.width.equalTo(70)
            make.height.equalTo(50)
        }
        
        albumButton.snp.makeConstraints{ make in
            make.width.equalTo(70)
            make.height.equalTo(50)
        }
        
        stackView.snp.makeConstraints{ make in
            make.top.equalTo(self.locationSelectionButton.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
        }
        
        snapshotImageView.snp.makeConstraints{ make in
            make.top.equalTo(self.stackView.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(150)
        }
        
        titleTextField.snp.makeConstraints{ make in
            make.top.equalTo(self.snapshotImageView.snp.bottom).offset(30)
            make.left.equalTo(self.view).offset(30)
            make.right.equalTo(self.view).offset(-30)
            make.height.equalTo(70)
        }
        
        contentTextField.snp.makeConstraints{ make in
            make.top.equalTo(self.titleTextField.snp.bottom).offset(30)
            make.left.equalTo(self.view).offset(30)
            make.right.equalTo(self.view).offset(-30)
            make.height.equalTo(70)
        }
        
        hashtagTextField.snp.makeConstraints{ make in
            make.top.equalTo(self.contentTextField.snp.bottom).offset(30)
            make.left.equalTo(self.view).offset(30)
            make.right.equalTo(self.view).offset(-30)
            make.height.equalTo(70)
        }
        
        registerButton.snp.makeConstraints{ make in
            make.bottom.equalTo(self.view).offset(-50)
            make.left.equalTo(self.view).offset(15)
            make.right.equalTo(self.view).offset(-15)
        }
    }
}
