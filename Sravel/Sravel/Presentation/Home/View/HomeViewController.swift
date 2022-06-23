//
//  HomeViewController.swift
//  Sravel
//
//  Created by asong on 2022/04/27.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class HomeViewController: UIViewController {
    private var disposeBag = DisposeBag()
    private var presentLocation: String = "광주"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureSubViews()
        self.congifureUI()
        self.setNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = presentLocation
    }
    
    private lazy var streetButton: UIButton = {
        let button = UIButton()
        button.setTitle("거리", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.backgroundColor = .lightBlue
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17.0, weight: .bold)
        button.layer.cornerRadius = 5
        return button
    }()
    
    private lazy var animalButton: UIButton = {
        let button = UIButton()
        button.setTitle("동물", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.backgroundColor = .lightBlue
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17.0, weight: .bold)
        button.layer.cornerRadius = 5
        return button
    }()
    
    private lazy var skyButton: UIButton = {
        let button = UIButton()
        button.setTitle("하늘", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.backgroundColor = .lightBlue
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17.0, weight: .bold)
        button.layer.cornerRadius = 5
        return button
    }()
    
    private lazy var oceanButton: UIButton = {
        let button = UIButton()
        button.setTitle("바다", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.backgroundColor = .lightBlue
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17.0, weight: .bold)
        button.layer.cornerRadius = 5
        return button
    }()
    
    private lazy var natureButton: UIButton = {
        let button = UIButton()
        button.setTitle("자연", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.backgroundColor = .lightBlue
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17.0, weight: .bold)
        button.layer.cornerRadius = 5
        return button
    }()
    
    private lazy var landmarkButton: UIButton = {
        let button = UIButton()
        button.setTitle("명소", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.backgroundColor = .lightBlue
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17.0, weight: .bold)
        button.layer.cornerRadius = 5
        return button
    }()
    
    private lazy var foodButton: UIButton = {
        let button = UIButton()
        button.setTitle("음식", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.backgroundColor = .lightBlue
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17.0, weight: .bold)
        button.layer.cornerRadius = 5
        return button
    }()
    
    private lazy var countryButton: UIButton = {
        let button = UIButton()
        button.setTitle("시골", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.backgroundColor = .lightBlue
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17.0, weight: .bold)
        button.layer.cornerRadius = 5
        return button
    }()
    
    private lazy var cityButton: UIButton = {
        let button = UIButton()
        button.setTitle("도시", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.backgroundColor = .lightBlue
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17.0, weight: .bold)
        button.layer.cornerRadius = 5
        return button
    }()
    
    private lazy var etcButton: UIButton = {
        let button = UIButton()
        button.setTitle("기타", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.backgroundColor = .lightBlue
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17.0, weight: .bold)
        button.layer.cornerRadius = 5
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 10.0
        stack.alignment = .fill
        stack.distribution = .fill
        [self.streetButton,
         self.skyButton,
         self.oceanButton, self.natureButton, self.animalButton, self.landmarkButton, self.foodButton, self.countryButton, self.cityButton, self.etcButton].forEach { stack.addArrangedSubview($0) }
        return stack
    }()
    
    private lazy var scrollView: UIScrollView = {
        let view: UIScrollView = UIScrollView()
        return view
    }()
}
extension HomeViewController{
    func configureSubViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
    }
    
    func congifureUI(){
        streetButton.snp.makeConstraints{ make in
            make.width.equalTo(70)
            make.height.equalTo(50)
        }
        
        skyButton.snp.makeConstraints{ make in
            make.width.equalTo(70)
            make.height.equalTo(50)
        }
        
        oceanButton.snp.makeConstraints{ make in
            make.width.equalTo(70)
            make.height.equalTo(50)
        }
        
        natureButton.snp.makeConstraints{ make in
            make.width.equalTo(70)
            make.height.equalTo(50)
        }
        
        animalButton.snp.makeConstraints{ make in
            make.width.equalTo(70)
            make.height.equalTo(50)
        }
        
        landmarkButton.snp.makeConstraints{ make in
            make.width.equalTo(70)
            make.height.equalTo(50)
        }
        
        foodButton.snp.makeConstraints{ make in
            make.width.equalTo(70)
            make.height.equalTo(50)
        }
        
        countryButton.snp.makeConstraints{ make in
            make.width.equalTo(70)
            make.height.equalTo(50)
        }
        
        cityButton.snp.makeConstraints{ make in
            make.width.equalTo(70)
            make.height.equalTo(50)
        }
        
        etcButton.snp.makeConstraints{ make in
            make.width.equalTo(70)
            make.height.equalTo(50)
        }
        
        scrollView.snp.makeConstraints{ make in
            make.left.equalTo(self.view).offset(10)
            make.right.equalTo(self.view).offset(-10)
            make.top.equalTo(self.view).offset(100)
            make.height.equalTo(50)
        }
        
        stackView.snp.makeConstraints{ make in
            make.left.equalTo(self.scrollView)
            make.right.equalTo(self.scrollView)
            make.top.equalTo(self.scrollView)
            make.height.equalTo(50)
        }
    }
    
    func setNavigationBar(){
        self.navigationItem.setHidesBackButton(true, animated:false)
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        let imageView = UIImageView(frame: CGRect(x: 10, y: 10, width: 20, height: 20))
        if let img = UIImage(named: "fullheart") {
            imageView.image = img
        }
        view.addSubview(imageView)
        let rightBarButtonItem = UIBarButtonItem(customView: view ?? UIView())
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
    }
}
