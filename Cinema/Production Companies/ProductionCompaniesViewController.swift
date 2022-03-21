//
//  ProductionCompanyViewController.swift
//  Cinema
//
//  Created by Anderson Sprenger on 18/03/22.
//

import UIKit
import CoreData

class ProductionCompaniesViewController: UITableViewController {

    var coordinator: ProductionCompaniesCoordinator?
    var productonCompanies: [ProductionCompany] = []
    var container: NSPersistentContainer {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError()
        }
        
        return appDelegate.persistentContainer
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: ProductionCompanyCell.id, bundle: nil), forCellReuseIdentifier: ProductionCompanyCell.id)
        
        productonCompanies = allProductionCompanies()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        productonCompanies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductionCompanyCell.id, for: indexPath) as! ProductionCompanyCell
        let productionCompany = productonCompanies[indexPath.row]

        cell.name.text = productionCompany.name
        cell.country.text = productionCompany.country
        cell.website.text = productionCompany.website
        
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coordinator?.showMovies(by: productonCompanies[indexPath.row])
    }
    
    // MARK: - Core Data

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            container.viewContext.delete(productonCompanies[indexPath.row])
            do {
                try container.viewContext.save()
            } catch {
                return
            }
            productonCompanies.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func allProductionCompanies() -> [ProductionCompany] {
        do {
            return try container.viewContext.fetch(ProductionCompany.fetchRequest())
        } catch {
            print(error.localizedDescription)
        }
        
        return []
    }
}
