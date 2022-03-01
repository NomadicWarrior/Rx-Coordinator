//
//  MoviesViewModel.swift
//  RxSwiftCourse
//
//  Created by Nurlan Akylbekov on 23.08.2021.
//

import Foundation
import RxSwift

class MoviesViewModel {
    
    var movies = Observable.just([
        Movie(name: "Movie 1"),
        Movie(name: "Movie 2"),
        Movie(name: "Movie 3")
    ])
    //let movies = PublishSubject<[Movie]>()
    
    func loadMOvies() {
//        let movieArray = [
//            Movie(name: "Movie 1"),
//            Movie(name: "Movie 2"),
//            Movie(name: "Movie 3")
//        ]
//        
//        movies.onNext(movieArray)
//        movies.onCompleted()
    }
}

struct Movie {
    let name: String
}
