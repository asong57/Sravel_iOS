//
//  DetailViewController.swift
//  Sravel
//
//  Created by asong on 2022/06/26.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class DetailViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureSubViews()
        self.congifureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "자세히 보기"
    }
    
    private lazy var snapshotImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "plus_photo")
        return imageView
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "2022.06.24"
        label.textColor = .blue
        return label
    }()
    
    private lazy var likeCountLabel: UILabel = {
        let label = UILabel()
        label.text = "1"
        label.textColor = .blue
        //label.backgroundColor = UIColor(patternImage: UIImage(named: "blank_like_number")!)
        return label
    }()
    
    private lazy var heartButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "like_full"), for: .normal)
        return button
    }()
    
    private lazy var downloadButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "save_full"), for: .normal)
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "뉴욕 엠파이어스테이트빌딩"
        label.textColor = .black
        label.font = label.font.withSize(25)
        return label
    }()
    
    private lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.text = "뉴욕을 여행하였습니다. 뉴욕 최고!!"
        label.textColor = .blue
        return label
    }()
    
    private lazy var hashtagLabel: UILabel = {
        let label = UILabel()
        label.text = "#도시 #건물"
        label.textColor = .blue
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 15.0
        stack.alignment = .fill
        stack.distribution = .fill
        [self.likeCountLabel, self.heartButton, self.downloadButton].forEach { stack.addArrangedSubview($0) }
        return stack
    }()

}
extension DetailViewController{
    func configureSubViews() {
        self.view.addSubview(snapshotImageView)
        self.view.addSubview(dateLabel)
        self.view.addSubview(stackView)
        self.view.addSubview(titleLabel)
        self.view.addSubview(contentLabel)
        self.view.addSubview(hashtagLabel)
    }
    
    func congifureUI(){
        
        downloadButton.snp.makeConstraints{ make in
            make.width.equalTo(30)
            make.height.equalTo(28)
        }
        
        heartButton.snp.makeConstraints{ make in
            make.width.equalTo(33)
            make.height.equalTo(28)
        }
        
        likeCountLabel.snp.makeConstraints{ make in
            //make.width.equalTo(33)
            //make.height.equalTo(28)
        }
        
        stackView.snp.makeConstraints{ make in
            make.top.equalTo(self.dateLabel.snp.bottom).offset(25)
            make.right.equalTo(self.view).offset(-15)
        }
        
        snapshotImageView.snp.makeConstraints{ make in
            make.top.equalTo(self.view).offset(100)
            make.centerX.equalToSuperview()
            make.left.equalTo(self.view).offset(10)
            make.right.equalTo(self.view).offset(-10)
            make.height.equalTo(400)
        }
        
        dateLabel.snp.makeConstraints{ make in
            make.top.equalTo(self.snapshotImageView.snp.bottom).offset(20)
            make.right.equalTo(self.view).offset(-15)
        }
        
        titleLabel.snp.makeConstraints{ make in
            make.top.equalTo(self.stackView.snp.bottom).offset(25)
            make.left.equalTo(self.view).offset(15)
        }
        
        contentLabel.snp.makeConstraints{ make in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(40)
            make.left.equalTo(self.view).offset(15)
        }
        
        hashtagLabel.snp.makeConstraints{ make in
            make.top.equalTo(self.contentLabel.snp.bottom).offset(30)
            make.left.equalTo(self.view).offset(15)
        }
    }
}
