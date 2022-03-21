//
//  MovieCoordinator.swift
//  Cinema
//
//  Created by Anderson Sprenger on 20/03/22.
//

import UIKit

class MoviesCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = MoviesViewController()
        vc.movies = vc.allMovies()
        
        navigationController.pushViewController(vc, animated: false)
        navigationController.navigationBar.prefersLargeTitles = true
        vc.title = "Movies"
        vc.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(vc.addData))
        
        print(#function)
    }
}
