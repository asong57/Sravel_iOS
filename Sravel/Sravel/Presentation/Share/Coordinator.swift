//
//  Coordinator.swift
//  Sravel
//
//  Created by asong on 2022/05/26.
//

import UIKit

protocol Coordinator: AnyObject{
    var presenter: UIViewController { get }
    
    func popup()
    func dismiss()
    func showRootDim(isShow: Bool)
    func showErrorAlert(error: Error)
    func openURL(url: String)
}

extension Coordinator{
    
    var presenter: UIViewController{
        return presenter
    }
    
    func popup() {
        self.presenter.navigationController?.popViewController(animated: true)
    }
    
    func dismiss() {
        self.presenter.dismiss(animated: true, completion: nil)
    }
}
