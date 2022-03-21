//
//  ActorsCoordinator.swift
//  Cinema
//
//  Created by Anderson Sprenger on 20/03/22.
//

import UIKit

class ActorsCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = ActorsViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
        navigationController.navigationBar.prefersLargeTitles = true
        vc.title = "Actors"
        
        print(#function)
    }
    
    func showMovies(with actor: Actor) {
        let vc = MoviesViewController()
        vc.movies = vc.allMovies(with: actor)
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.title = "\(actor.name ?? "Actor")'s movies"
        navigationController.pushViewController(vc, animated: false)

        print(#function)
    }
}
