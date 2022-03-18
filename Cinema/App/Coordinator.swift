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
        let tabBarViewController = UITabBarController()
        
        let v1 = ViewController.instantiate()
        v1.coordinator = self
        v1.movies = v1.allMovies()
        v1.title = "Movies"
        
        let v2 = ActorsViewController()
        v2.coordinator = self
        v2.title = "Actors"
        
        let v3 = ProductionCompanyViewController.instantiate()
        v3.coordinator = self
        v3.title = "Production Companies"
        
        let ncv1 = UINavigationController(rootViewController: v1)
        let ncv2 = UINavigationController(rootViewController: v2)
        let ncv3 = UINavigationController(rootViewController: v3)

        tabBarViewController.setViewControllers([ncv1, ncv2, ncv3], animated: false)
        
        guard let items = tabBarViewController.tabBar.items else { fatalError() }
        
        let imageName = ["film", "pearson", "star"]
        
        for i in 0..<imageName.count {
            items[i].image = UIImage(systemName: imageName[i])
        }
        
        navigationController.pushViewController(tabBarViewController, animated: false)
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
    
    func showProductionCompanies() {
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
