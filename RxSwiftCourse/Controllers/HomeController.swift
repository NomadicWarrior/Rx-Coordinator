//
//  HomeController.swift
//  RxSwiftCourse
//
//  Created by Nurlan Akylbekov on 23.08.2021.
//

import UIKit
import RxSwift
import RxCocoa

class HomeController: UIViewController {

    let simpleRxBtn = UIButton(backgroundColor: .systemRed,
                               title: "Simple Rx Button",
                               titleColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0),
                               cornerRadius: 5,
                               borderWidth: 0.5,
                               borderColor: UIColor.black.cgColor)
    
    
    var disposeBag = DisposeBag()
    
    var coordinator: MainCoordinator
    
    init(coordinator: MainCoordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        design()
        
        simpleRxBtn.rx.tap
            .bind { (tap) in
                self.coordinator.openMoviesController()
            }.disposed(by: disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        title = "Rx, Coordinator"
        navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemRed]
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemRed]
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
}

// MARK: - Design
extension HomeController {
    private func design() {
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        view.addSubview(simpleRxBtn)
        
        NSLayoutConstraint.activate([
            simpleRxBtn.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.65),
            simpleRxBtn.heightAnchor.constraint(equalToConstant: 45),
            simpleRxBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            simpleRxBtn.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        
        
        
    }
}
