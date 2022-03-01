//
//  MovieController.swift
//  RxSwiftCourse
//
//  Created by Nurlan Akylbekov on 23.08.2021.
//

import UIKit

class MovieController: UIViewController {

    var viewModel: MovieViewModel
    
    init(viewModel: MovieViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        title = viewModel.movie.name
        
    }

}
