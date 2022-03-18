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

    func showMovies() {
        let vc = ViewController.instantiate()
        vc.coordinator = self
        
        vc.movies = vc.allMovies()
        
        navigationController.pushViewController(vc, animated: false)
    }
    
    func showMovies(with actor: Actor) {
        let vc = ViewController.instantiate()
        vc.coordinator = self
        
        vc.movies = vc.allMovies(with: actor)
        
        navigationController.pushViewController(vc, animated: false)
    }
    
    func showMovies(by productionCompany: ProductionCompany) {
        let vc = ViewController.instantiate()
        vc.coordinator = self
        
        vc.movies = vc.allMovies(by: productionCompany)
        
        navigationController.pushViewController(vc, animated: false)
    }
    
    func showActors() {
        let vc = ActorsViewController.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func showProdCompanies() {
        let vc = ProductionCompanyViewController.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
}


protocol Storyboarded {
    static func instantiate() -> Self
}

extension Storyboarded where Self: UIViewController {
    static func instantiate() -> Self {
        // this pulls out "MyApp.MyViewController"
        let fullName = NSStringFromClass(self)

        // this splits by the dot and uses everything after, giving "MyViewController"
        let className = fullName.components(separatedBy: ".")[1]

        // load our storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)

        // instantiate a view controller with that identifier, and force cast as the type that was requested
        return storyboard.instantiateViewController(withIdentifier: className) as! Self
    }
}
