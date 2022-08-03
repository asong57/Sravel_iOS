//
//  DetailViewController.swift
//  Sravel
//
//  Created by asong on 2022/07/05.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class DetailViewController: UIViewController {
    
    var viewModel: DetailViewModel?
    private var disposeBag = DisposeBag()
    private var uid = "songUid"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureSubViews()
        self.congifureUI()
        self.bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "자세히 보기"
    }
    
    static func create(with viewModel: DetailViewModel) -> DetailViewController{
        let view = DetailViewController()
        view.viewModel = viewModel
        return view
    }
    
    private lazy var snapshotImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ny")
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
        button.setImage(UIImage(named: "like"), for: .normal)
        return button
    }()
    
    private lazy var downloadButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "save"), for: .normal)
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "뉴욕 엠파이어스테이트빌딩"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 25)
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
        [ self.heartButton, self.downloadButton].forEach { stack.addArrangedSubview($0) }
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

extension DetailViewController {
    func bindViewModel(){
        let input = DetailViewModel.Input(readyToGetDetailData: Observable.just(true), heartButtonDidTapEvent: heartButton.rx.tap.asObservable(), downloadButtonDidTapEvent: downloadButton.rx.tap.asObservable())
        guard let viewModel = self.viewModel else{return}
        let output = viewModel.transform(from: input, disposeBag: self.disposeBag)
        bindMarker(output: output)
    }
    
    func bindMarker(output: DetailViewModel.Output?){
        output?.detailMarkerData
            .subscribe(onNext: { [weak self] data in
                guard let self = self else { return }
                self.titleLabel.text = data.title
                self.contentLabel.text = data.description
                self.hashtagLabel.text = data.hashtag + data.hashtag2
                let time: String = data.time
                let timeStr: String = String(time[time.index(time.startIndex, offsetBy: 0)...time.index(time.startIndex, offsetBy: 3)]) + "." + String(time[time.index(time.startIndex, offsetBy: 4)...time.index(time.startIndex, offsetBy: 5)]) + "." + String(time[time.index(time.startIndex, offsetBy: 6)...time.index(time.startIndex, offsetBy: 7)])
                self.dateLabel.text = timeStr
                let url = URL(string: data.imageUrl + ".jpg")
                let imageData = try! Data(contentsOf: url!)
                self.snapshotImageView.image = UIImage(data: imageData)
                if let _ = data.heartCheck[self.uid] {
                    self.heartButton.setImage(UIImage(named: "like_full"), for: .normal)
                } else {
                    self.heartButton.setImage(UIImage(named: "like"), for: .normal)
                }
            })
            .disposed(by: disposeBag)
    }
}
