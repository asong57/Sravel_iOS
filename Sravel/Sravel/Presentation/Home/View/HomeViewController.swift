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
import GoogleMaps

final class HomeViewController: UIViewController {
    var viewModel: HomeViewModel?
    private var disposeBag = DisposeBag()
    private var presentLocation: String = "광주광역시 북구 용봉동 147"
    private var mapView: GMSMapView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureSubViews()
        self.congifureUI()
        self.setNavigationBar()
        self.setPresentLocation()
        self.setMarker()
        self.moveToPlusViewController()
        self.bindViewModel()
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
        if let img = UIImage(named: "search") {
            imageView.image = img
        }
        view.addSubview(imageView)
        let rightBarButtonItem = UIBarButtonItem(customView: view ?? UIView())
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
    }
}

// MARK: ViewModel Bind

extension HomeViewController{
    func bindViewModel(){
        let input = HomeViewModel.Input()
        guard let viewModel = self.viewModel else{return}
        let output = viewModel.transform(from: input, disposeBag: self.disposeBag)
        self.bindMarkers(output: output)
    }
    
    func bindMarkers(output: HomeViewModel.Output?){
        output?.markersData
            .subscribe(onNext: { [weak self] dataArr in
                guard let self = self else { return }
                for data in dataArr{
                    let marker = GMSMarker()
                    marker.position = CLLocationCoordinate2D(latitude: data.latitude, longitude: data.longitude)
                    switch data.hashtag{
                    case "#하늘" :
                        marker.icon = self.imageWithImage(image: UIImage(named: "mark_sky")!, scaledToSize: CGSize(width: 60.0, height: 80.0))
                    case "#바다" :
                        marker.icon = self.imageWithImage(image: UIImage(named: "mark_sea")!, scaledToSize: CGSize(width: 60.0, height: 80.0))
                    case "#음식" :
                        marker.icon = self.imageWithImage(image: UIImage(named: "mark_food")!, scaledToSize: CGSize(width: 60.0, height: 80.0))
                    case "#명소" :
                        marker.icon = self.imageWithImage(image: UIImage(named: "mark_landmark")!, scaledToSize: CGSize(width: 60.0, height: 80.0))
                    case "#거리" :
                        marker.icon = self.imageWithImage(image: UIImage(named: "mark_street")!, scaledToSize: CGSize(width: 60.0, height: 80.0))
                    case "#도시" :
                        marker.icon = self.imageWithImage(image: UIImage(named: "mark_building")!, scaledToSize: CGSize(width: 60.0, height: 80.0))
                    case "#시골" :
                        marker.icon = self.imageWithImage(image: UIImage(named: "mark_country")!, scaledToSize: CGSize(width: 60.0, height: 80.0))
                    case "#자연" :
                        marker.icon = self.imageWithImage(image: UIImage(named: "mark_nature")!, scaledToSize: CGSize(width: 60.0, height: 80.0))
                    case "#동물" :
                        marker.icon = self.imageWithImage(image: UIImage(named: "mark_animal")!, scaledToSize: CGSize(width: 60.0, height: 80.0))
                    default:
                        marker.icon = self.imageWithImage(image: UIImage(named: "mark_building")!, scaledToSize: CGSize(width: 60.0, height: 80.0))
                    }
                    
                    marker.map = self.mapView
                }
            })
            .disposed(by: disposeBag)
    }
}

 // MARK: Marker 관련 작업

extension HomeViewController: CLLocationManagerDelegate{
    func setPresentLocation(){
        var locationManager: CLLocationManager!
        // 현재 위치 가져오기
        locationManager = CLLocationManager()
        locationManager.delegate = self
        
        // 앱이 실행될 때 위치 추적 권한 요청
        locationManager.requestWhenInUseAuthorization()
        // 배터리에 맞게 권장되는 최적의 정확도
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        // 위치 업데이트
        locationManager.startUpdatingLocation()
        
        // 위, 경도 가져오기
        let coor = locationManager.location?.coordinate
        
        let latitude = (coor?.latitude ?? 37.566508) as Double
        let longitude = (coor?.longitude ?? 126.977945) as Double
        print("\(latitude)")
        
        let camera = GMSCameraPosition.camera(withLatitude: 37.566508, longitude: 126.977945, zoom: 16.0)
        mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
        self.view.addSubview(mapView!)
        
        mapView!.snp.makeConstraints{ make in
            make.bottom.equalTo(self.view).offset(-5)
            make.top.equalTo(self.scrollView.snp.bottom).offset(5)
            make.left.right.equalTo(self.view)
        }
    }
    
    func setMarker(){
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: 37.566508, longitude: 126.977945)
        marker.icon = self.imageWithImage(image: UIImage(named: "mark_building")!, scaledToSize: CGSize(width: 60.0, height: 80.0))
        marker.map = mapView
        
        let marker2 = GMSMarker()
        marker2.position = CLLocationCoordinate2D(latitude: 37.568500, longitude: 126.978945)
        marker2.icon = self.imageWithImage(image: UIImage(named: "mark_animal")!, scaledToSize: CGSize(width: 60.0, height: 80.0))
        marker2.map = mapView
        
        let marker3 = GMSMarker()
        marker3.position = CLLocationCoordinate2D(latitude: 37.563518, longitude: 126.974945)
        marker3.icon = self.imageWithImage(image: UIImage(named: "mark_food")!, scaledToSize: CGSize(width: 60.0, height: 80.0))
        marker3.map = mapView
    }
    
    func imageWithImage(image:UIImage, scaledToSize newSize:CGSize) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
}

// MARK: Navigation
 // 수정 예정
extension HomeViewController{
    func moveToPlusViewController(){
        streetButton.rx.tap
            .throttle(.seconds(2), scheduler: MainScheduler.instance)
            .subscribe(onNext:  { [weak self] in
                let signUpVC = PlusSnapshotViewController()
                signUpVC.view.backgroundColor = .white
                self?.navigationController?.navigationBar.tintColor = .blue
                self?.navigationController?.navigationBar.topItem?.title = ""
                self?.navigationController?.pushViewController(signUpVC, animated: true)
            }).disposed(by: disposeBag)
        
        skyButton.rx.tap
            .throttle(.seconds(2), scheduler: MainScheduler.instance)
            .subscribe(onNext:  { [weak self] in
                let signUpVC = DetailViewController()
                signUpVC.view.backgroundColor = .white
                self?.navigationController?.navigationBar.tintColor = .blue
                self?.navigationController?.navigationBar.topItem?.title = ""
                self?.navigationController?.pushViewController(signUpVC, animated: true)
            }).disposed(by: disposeBag)
    }
}

// MARK: GMPSMapViewDelegate

extension HomeViewController: GMSMapViewDelegate{
    // 마커 클릭 이벤트 delegate
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        mapView.animate(toLocation: marker.position)
        return false
    }
}
