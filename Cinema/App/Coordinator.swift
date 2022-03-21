//
//  Coordinator.swift
//  Cinema
//
//  Created by Anderson Sprenger on 20/03/22.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get }
    
    init(navigationController: UINavigationController)
    func start()
}
