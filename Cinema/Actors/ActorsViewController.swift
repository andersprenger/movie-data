//
//  ActorsViewController.swift
//  Cinema
//
//  Created by Anderson Sprenger on 18/03/22.
//

import UIKit
import CoreData

class ActorsViewController: UITableViewController {
    
    var coordinator: Coordinator? = nil
    
    var actors: [Actor] = []
    
    var container: NSPersistentContainer {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError()
        }
        
        return appDelegate.persistentContainer
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Actors"
        
        tableView.register(UINib(nibName: ActorCell.id, bundle: nil), forCellReuseIdentifier: ActorCell.id)
        
        actors = allActors()
    }

    // MARK: - Table view

    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        actors.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ActorCell.id, for: indexPath) as! ActorCell
        let actor = actors[indexPath.row]
        
        cell.name.text = actor.name
        cell.gender.text = actor.gender
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d, yyyy"
        cell.birthDate.text = dateFormatter.string(from: actor.birthDate!)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coordinator?.showMovies(with: actors[indexPath.row])
    }
        
    // MARK: Core Data
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            container.viewContext.delete(actors[indexPath.row])
            do {
                try container.viewContext.save()
            } catch {
                return
            }
            actors.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    func allActors() -> [Actor] {
        do {
            return try container.viewContext.fetch(Actor.fetchRequest())
        } catch {
            print(error.localizedDescription)
        }
        
        return []
    }
}
