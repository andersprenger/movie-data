//
//  TabViewController.swift
//  Cinema
//
//  Created by Anderson Sprenger on 19/03/22.
//

import UIKit

class MainTabViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let movies = MoviesViewController()
        let moviesNavigationController = UINavigationController()
        let moviesCoordinator = MoviesCoordinator(navigationController: moviesNavigationController)
        movies.coordinator = moviesCoordinator
        movies.movies = movies.allMovies()
        moviesCoordinator.start()
        
        let actors = ActorsViewController()
        let actorsNavigationController = UINavigationController()
        let actorsCoordinator = ActorsCoordinator(navigationController: actorsNavigationController)
        actors.coordinator = actorsCoordinator
        actorsCoordinator.start()
        
        let production = ProductionCompaniesViewController()
        let productionNavigationController = UINavigationController()
        let productionCoordinator = ProductionCompaniesCoordinator(navigationController: productionNavigationController)
        production.coordinator = productionCoordinator
        productionCoordinator.start()
        
        setViewControllers(
            [moviesNavigationController, actorsNavigationController, productionNavigationController],
            animated: false
        )
        
        guard let items = tabBar.items else { fatalError() }
        
        let imageName = ["film", "person", "star"]
        
        for i in 0..<imageName.count {
            items[i].image = UIImage(systemName: imageName[i])
        }
    }
}
