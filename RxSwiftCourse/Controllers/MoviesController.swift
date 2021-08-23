//
//  MoviesController.swift
//  RxSwiftCourse
//
//  Created by Nurlan Akylbekov on 23.08.2021.
//

import UIKit
import RxSwift
import RxCocoa

class MoviesController: UIViewController {

    let tableview: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .clear
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    let searchController = UISearchController()
    
    var coordinator: MainCoordinator
    
    var disposeBag = DisposeBag()
    
    var movies = ["Movie 1", "Movie 2", "Movie 3"]
    
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
        
        
        //tableview.rx.items(cellIdentifier: "cell", cellType: UITableViewCell.self){ row, item, cell in
            
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        title = "Movies"
        navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemRed]
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemRed]
        navigationController?.navigationBar.topItem?.title = ""
        navigationController?.navigationItem.leftBarButtonItem?.tintColor = .systemRed
        
        navigationItem.searchController = searchController
    }

}


// MARK: - Design
extension MoviesController {
    private func design() {
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        view.addSubview(tableview)
        tableview.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true
        tableview.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableview.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableview.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        
        searchController.searchBar.placeholder = "SEARCH MOVIE"
    }
}

 /*extension MoviesController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableview.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? UITableViewCell else { fatalError("No Cell") }
        cell.textLabel?.text = "Movies"
        return cell
    }
    
    
}*/
