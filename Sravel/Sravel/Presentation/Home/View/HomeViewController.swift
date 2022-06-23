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

}
extension HomeViewController{
    func configureSubViews() {
        
    }
    
    func congifureUI(){
        
    }
    
    func setNavigationBar(){
        self.navigationItem.setHidesBackButton(true, animated:false)

           //your custom view for back image with custom size
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
