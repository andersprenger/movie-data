//
//  Coordinator.swift
//  Cinema
//
//  Created by Anderson Sprenger on 18/03/22.
//

import UIKit

class Coordinator {
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func show() {
        let tabBarViewController = TabViewController()
        tabBarViewController.coordinator = self
        navigationController.pushViewController(tabBarViewController, animated: false)
        
        print(#function)
    }

    func showMovies() {
        let vc = MovieViewController()
        vc.coordinator = self
        
        vc.movies = vc.allMovies()
        
        navigationController.pushViewController(vc, animated: false)
        
        print(#function)
    }
    
    func showMovies(with actor: Actor) {
        let vc = MovieViewController()
        vc.coordinator = self
        
        vc.movies = vc.allMovies(with: actor)
        
        navigationController.pushViewController(vc, animated: false)
        
        print(#function)
    }
    
    func showMovies(by productionCompany: ProductionCompany) {
        let vc = MovieViewController()
        vc.coordinator = self
        
        vc.movies = vc.allMovies(by: productionCompany)
        
        navigationController.pushViewController(vc, animated: false)
        
        print(#function)
    }
    
    func showActors() {
        let vc = ActorsViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
        
        print(#function)
    }
    
    func showProductionCompanies() {
        let vc = ProductionCompanyViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
        
        print(#function)
    }
}
