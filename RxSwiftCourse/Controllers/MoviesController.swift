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
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: "cell")
        return collectionView
    }()
    
    let searchController = UISearchController()
    
    private var coordinator: MainCoordinator
    private var viewModel: MoviesViewModel
    
    var disposeBag = DisposeBag()
    
    init(coordinator: MainCoordinator, viewModel: MoviesViewModel) {
        self.coordinator = coordinator
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        design()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.setupTableView()
        }
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

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}


// MARK: - Design
extension MoviesController {
    private func design() {
        view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        view.addSubview(tableview)
        tableview.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true
        tableview.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableview.bottomAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        tableview.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        view.addSubview(collectionView)
        
        collectionView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6).isActive = true
        collectionView.topAnchor.constraint(equalTo: tableview.bottomAnchor, constant: 30).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        searchController.searchBar.placeholder = "SEARCH MOVIE"
    }
}

// MARK: - Table View
extension MoviesController: UITableViewDelegate, UICollectionViewDelegateFlowLayout {
    private func setupTableView() {
        tableview.delegate = self
        
        viewModel.loadMOvies()
        
        viewModel.movies.bind(to: tableview.rx.items(cellIdentifier: "cell", cellType: UITableViewCell.self)) { row, item, cell in
            cell.textLabel?.text = item.name
            cell.selectionStyle = .none
        }.disposed(by: disposeBag)
        
        tableview.rx.modelSelected(Movie.self)
            .subscribe(onNext: { movie in
                let movie = MovieViewModel(movie: movie)
                self.coordinator.openMovieController(viewModel: movie)
            })
            .disposed(by: disposeBag)
        
        
        viewModel.movies.bind(to: collectionView.rx.items(cellIdentifier: "cell", cellType: MovieCell.self)) {
            row, item, cell in
            cell.inserData(movie: item)
            let indexPath:IndexPath = IndexPath(row: 0, section: 0)
            self.collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .top)
        }
        .disposed(by: disposeBag)
        
        collectionView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let label = UILabel(frame: CGRect.zero)
        //label.text = viewModel.movies[indexPath.item]
        label.sizeToFit()
        return CGSize(width: 68, height: 32)
    }
}


class MovieCell: UICollectionViewCell {
    let nameCell = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        nameCell.textColor = .blue
        contentView.backgroundColor = .white
        nameCell.numberOfLines = 1
        contentView.layer.cornerRadius = 16
        nameCell.textAlignment = .center
        nameCell.font = .systemFont(ofSize: 14, weight: .semibold)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func inserData(movie: Movie) {
        nameCell.text = movie.name
        nameCell.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(nameCell)
        nameCell.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        nameCell.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
    }
    
    override var isSelected: Bool {
        didSet {
            nameCell.textColor = isSelected ? .white : .blue
            contentView.backgroundColor = isSelected ? .black : .white
        }
    }
}
