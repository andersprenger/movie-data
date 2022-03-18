//
//  ViewController.swift
//  Cinema
//
//  Created by Anderson Sprenger on 17/03/22.
//

import UIKit
import CoreData

class ViewController: UITableViewController, Storyboarded {
    
    weak var coordinator: Coordinator? = nil
    
    var container: NSPersistentContainer {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError()
        }
        
        return appDelegate.persistentContainer
    }
    
    var movies: [Movie] = []

    override func viewDidLoad() {
        super.viewDidLoad()
 
        navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Movies"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addData))
        
        if UserDefaults.standard.bool(forKey: "isPopulated") == false {
            addData()
        }
    }
    
    // MARK: - Table

    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movie-cell", for: indexPath) as! MovieTableViewCell
        let movie = movies[indexPath.row]
        
        cell.name.text = movie.name
        cell.length.text = "\(movie.length) min"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d, yyyy"
        
        cell.date.text = dateFormatter.string(from: movie.releaseDate!)
        cell.revenue.text = "Revenue \(movie.revenue)"
        
        cell.productionCompany.text = movie.productionCompany?.name
        
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            container.viewContext.delete(movies[indexPath.row])
            do {
                try container.viewContext.save()
            } catch {
                return
            }
            movies.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: - Helper
    
    func dateHelper(day: Int, month: Int, year: Int) -> Date? {
        var components = DateComponents()
        components.day = day
        components.month = month
        components.year = year
        
        return Calendar(identifier: .gregorian).date(from: components)
    }
    
    // MARK: - Code Data
    
    func allMovies() -> [Movie] {
        do {
            return try container.viewContext.fetch(Movie.fetchRequest())
        } catch {
            print(error.localizedDescription)
        }
        
        return []
    }
    
    func allMovies(with actor: Actor) -> [Movie] {
        actor.movies?.allObjects as? [Movie] ?? []
    }
    
    func allMovies(by productionCompany: ProductionCompany) -> [Movie] {
        productionCompany.movies?.allObjects as? [Movie] ?? []
    }
    
    @objc private func addData() {
        // *******************************************************
        // MOVIES
        // *******************************************************
        let movie1 = Movie(context: container.viewContext)
        movie1.name = "The Batman"
        movie1.releaseDate = dateHelper(day: 03, month: 03, year: 2022)
        movie1.length = 185
        movie1.revenue = 200_000_000.00

        let movie2 = Movie(context: container.viewContext)
        movie2.name = "Avengers: Infinity War"
        movie2.releaseDate = dateHelper(day: 26, month: 04, year: 2018)
        movie2.length = 150
        movie2.revenue = 2_000_000_000.00

        let movie3 = Movie(context: container.viewContext)
        movie3.name = "Sherlock Holmes: A Game of Shadows"
        movie3.releaseDate = dateHelper(day: 13, month: 01, year: 2012)
        movie3.length = 145
        movie3.revenue = 80_000_000.00

        let movie4 = Movie(context: container.viewContext)
        movie4.name = "Spider-Man: No Way Home"
        movie4.releaseDate = dateHelper(day: 16, month: 12, year: 2021)
        movie4.length = 160
        movie4.revenue = 4_000_000_000.00

        let movie5 = Movie(context: container.viewContext)
        movie5.name = "Rogue One: A Star Wars Story"
        movie5.releaseDate = dateHelper(day: 15, month: 12, year: 2016)
        movie5.length = 80
        movie5.revenue = 140_000_000.00

        let movie6 = Movie(context: container.viewContext)
        movie6.name = "Guardians of the Galaxy"
        movie6.releaseDate = dateHelper(day: 13, month: 01, year: 2012)
        movie6.length = 150
        movie6.revenue = 220_000_000.00

        let movie7 = Movie(context: container.viewContext)
        movie7.name = "Family Guy"
        movie7.releaseDate = dateHelper(day: 16, month: 12, year: 2021)
        movie7.length = 30
        movie7.revenue = 200_000_000.00

        let movie8 = Movie(context: container.viewContext)
        movie8.name = "Dr. No"
        movie8.releaseDate = dateHelper(day: 07, month: 09, year: 1963)
        movie8.length = 100
        movie8.revenue = 30_000_000.00

        // *******************************************************
        // ACTORS
        // *******************************************************
        let actor1 = Actor(context: container.viewContext)
        actor1.name = "Felicity Jones"
        actor1.gender = "Female"
        actor1.birthDate = dateHelper(day: 17, month: 10, year: 1983)
        
        let actor2 = Actor(context: container.viewContext)
        actor2.name = "Diego Luna"
        actor2.gender = "Male"
        actor2.birthDate = dateHelper(day: 29, month: 12, year: 1979)
        
        let actor3 = Actor(context: container.viewContext)
        actor3.name = "Alan Tudyk"
        actor3.gender = "Male"
        actor3.birthDate = dateHelper(day: 16, month: 03, year: 1971)
        
        movie1.cast = NSSet(array: [actor1, actor2, actor3])
        
        let actor4 = Actor(context: container.viewContext)
        actor4.name = "Robert Downey Jr."
        actor4.gender = "Male"
        actor4.birthDate = dateHelper(day: 12, month: 12, year: 1970)
        
        let actor5 = Actor(context: container.viewContext)
        actor5.name = "Tom Holland"
        actor5.gender = "Male"
        actor5.birthDate = dateHelper(day: 01, month: 03, year: 2001)
        
        let actor6 = Actor(context: container.viewContext)
        actor6.name = "Zendaya"
        actor6.gender = "Female"
        actor6.birthDate = dateHelper(day: 21, month: 05, year: 2002)
        
        movie2.cast = NSSet(array: [actor4, actor5, actor6, actor2])
        
        let actor7 = Actor(context: container.viewContext)
        actor7.name = "Robert Pattinson"
        actor7.gender = "Male"
        actor7.birthDate = dateHelper(day: 4, month: 9, year: 1980)
        
        let actor8 = Actor(context: container.viewContext)
        actor8.name = "Zoë Kravitz"
        actor8.gender = "Male"
        actor8.birthDate = dateHelper(day: 01, month: 01, year: 1940)
        
        let actor9 = Actor(context: container.viewContext)
        actor9.name = "Paul Dano"
        actor9.gender = "Male"
        actor9.birthDate = dateHelper(day: 14, month: 11, year: 1985)
        
        movie3.cast = NSSet(array: [actor7, actor8, actor9, actor1])
        
        let actor10 = Actor(context: container.viewContext)
        actor10.name = "Alex Borstein"
        actor10.gender = "Female"
        actor10.birthDate = dateHelper(day: 14, month: 01, year: 1984)
        
        let actor11 = Actor(context: container.viewContext)
        actor11.name = "Greg Kinnear"
        actor11.gender = "Male"
        actor11.birthDate = dateHelper(day: 21, month: 09, year: 2000)
        
        let actor12 = Actor(context: container.viewContext)
        actor12.name = "Steve Carell"
        actor12.gender = "Male"
        actor12.birthDate = dateHelper(day: 14, month: 08, year: 1979)
        
        movie4.cast = NSSet(array: [actor10, actor11, actor12, actor1])
        
        let actor13 = Actor(context: container.viewContext)
        actor13.name = "Jim Carrey"
        actor13.gender = "Male"
        actor13.birthDate = dateHelper(day: 27, month: 7, year: 2040)
        
        let actor14 = Actor(context: container.viewContext)
        actor14.name = "Morgan Freeman"
        actor14.gender = "Male"
        actor14.birthDate = dateHelper(day: 19, month: 6, year: 1987)
        
        let actor15 = Actor(context: container.viewContext)
        actor15.name = "Jennifer Aniston"
        actor15.gender = "Female"
        actor15.birthDate = dateHelper(day: 4, month: 5, year: 1970)
        
        let actor16 = Actor(context: container.viewContext)
        actor16.name = "Matthew Perry"
        actor16.gender = "Male"
        actor16.birthDate = dateHelper(day: 9, month: 4, year: 1980)
        
        movie5.cast = NSSet(array: [actor16, actor3, actor3, actor1])
        movie6.cast = NSSet(array: [actor15, actor2, actor4, actor3])
        movie7.cast = NSSet(array: [actor14, actor1, actor5, actor3])
        movie8.cast = NSSet(array: [actor13, actor2, actor11, actor4])

        // *******************************************************
        // PRODUCTION COMPANIES
        // *******************************************************
        let pc1 = ProductionCompany(context: container.viewContext)
        pc1.name = "Disney"
        pc1.country = "US"
        pc1.website = "disney.com"
        pc1.movies = NSSet(array: [movie2, movie3, movie5, movie6])

        let pc2 = ProductionCompany(context: container.viewContext)
        pc2.name = "Warner"
        pc2.country = "US"
        pc2.website = "warner.com"
        pc2.movies = NSSet(array: [movie1, movie7])
        
        let pc3 = ProductionCompany(context: container.viewContext)
        pc3.name = "Sony"
        pc3.country = "JP"
        pc3.website = "sony.com"
        pc3.movies = NSSet(array: [movie4, movie8])
        
        try! container.viewContext.save()
        
        // *******************************************************
        // DEFAUTS
        // *******************************************************
        UserDefaults.standard.set(true, forKey: "isPopulated")
        print("populou")
        
        movies = allMovies()
        tableView.reloadData()
    }
}

