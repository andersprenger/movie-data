//
//  ProductionCompaniesCoordinator.swift
//  Cinema
//
//  Created by Anderson Sprenger on 20/03/22.
//

import UIKit

class ProductionCompaniesCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = ProductionCompaniesViewController()
        vc.coordinator = self
        navigationController.navigationBar.prefersLargeTitles = true
        vc.title = "Production Companies"
        navigationController.pushViewController(vc, animated: false)

        print(#function)
    }
    
    func showMovies(by productionCompany: ProductionCompany) {
        let vc = MoviesViewController()
        vc.coordinator = self
        vc.movies = vc.allMovies(by: productionCompany)
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.title = "\(productionCompany.name ?? "Company")'s movies"
        navigationController.pushViewController(vc, animated: false)

        print(#function)
    }
}
