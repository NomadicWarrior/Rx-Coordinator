//
//  Coordinator.swift
//  RxSwiftCourse
//
//  Created by Nurlan Akylbekov on 23.08.2021.
//

import UIKit

protocol Coordinator {
    
    var navigationController: UINavigationController {  get set }
    func start()
}
