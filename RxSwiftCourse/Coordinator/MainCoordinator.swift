//
//  MainCoordinator.swift
//  RxSwiftCourse
//
//  Created by Nurlan Akylbekov on 23.08.2021.
//

import UIKit

class MainCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let homeController = HomeController(coordinator: self)
        navigationController.pushViewController(homeController, animated: false)
    }
    
    func openMoviesController() {
        let viewModel = MoviesViewModel()
        let moviesController = MoviesController(coordinator: self, viewModel: viewModel)
        push(controller: moviesController)
    }
    
    func openMovieController(viewModel: MovieViewModel) {
        let movieController = MovieController(viewModel: viewModel)
        push(controller: movieController)
    }
    
    private func push(controller: UIViewController) {
        navigationController.pushViewController(controller, animated: true)
    }
}
