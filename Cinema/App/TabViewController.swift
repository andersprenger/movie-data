//
//  TabViewController.swift
//  Cinema
//
//  Created by Anderson Sprenger on 19/03/22.
//

import UIKit

class TabViewController: UITabBarController {
    var coordinator: Coordinator? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let movies = MovieViewController()
        movies.coordinator = coordinator
        movies.movies = movies.allMovies()
        movies.title = "Movies"
        
        let actors = ActorsViewController()
        actors.coordinator = coordinator
        actors.title = "Actors"
        
        let productionCompanies = ProductionCompanyViewController()
        productionCompanies.coordinator = coordinator
        productionCompanies.title = "Production Companies"
        
        let ncMovies = UINavigationController(rootViewController: movies)
        let ncActors = UINavigationController(rootViewController: actors)
        let ncProductionCompanies = UINavigationController(rootViewController: productionCompanies)

        setViewControllers([ncMovies, ncActors, ncProductionCompanies], animated: false)
        
        guard let items = tabBar.items else { fatalError() }
        
        let imageName = ["film", "person", "star"]
        
        for i in 0..<imageName.count {
            items[i].image = UIImage(systemName: imageName[i])
        }
    }
}
