//
//  CoreDataManager.swift
//  CoreDataTutorial
//
//  Created by paige shin on 2023/01/12.
//

import Foundation
import CoreData

class CoreDataManager {
    
    let persistentContainer: NSPersistentContainer
    
    init() {
        self.persistentContainer = NSPersistentContainer(name: "HelloCoreDataModel")
        self.persistentContainer.loadPersistentStores { desc, error in
            if let error {
                fatalError("Core Data Store failed to initialize \(error.localizedDescription)")
            }
        }
    }
    
    func getAllMovies() -> [Movie] {
        let fetchRequest: NSFetchRequest<Movie> = Movie.fetchRequest()
        do {
            return try self.persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    func saveMovie(title: String) {
        
        let movie = Movie(context: self.persistentContainer.viewContext)
        movie.title = title 
        do {
            try self.persistentContainer.viewContext.save()
        } catch {
            self.persistentContainer.viewContext.rollback()
            print(error.localizedDescription)
        }
        
    }
    
    func updateMovie() {
        do {
            try self.persistentContainer.viewContext.save()
        } catch {
            self.persistentContainer.viewContext.rollback()
        }
    }
    
    func deleteMovie(movie: Movie) {
        self.persistentContainer.viewContext.delete(movie)
        do {
            try self.persistentContainer.viewContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
}
