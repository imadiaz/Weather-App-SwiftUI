//
//  Persistence.swift
//  weather
//
//  Created by Ancient on 06/05/21.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "weather")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
    func saveLocation(city: City){
        let result = PersistenceController(inMemory: false)
        let viewContext = result.container.viewContext
        let location = LocationEntity(context: viewContext)
        location.name = city.name
        location.latitude = city.coord.lat
        location.longitude = city.coord.lon
        do {
            try viewContext.save()
            print("City saved")
        }catch {
            print("Error saving location \(error.localizedDescription)")
        }
    }
    
    func getLocations() -> [LocationEntity] {
        let result = PersistenceController(inMemory: false)
        let viewContext = result.container.viewContext
        let fetchRequest: NSFetchRequest<LocationEntity> = LocationEntity.fetchRequest()
        do {
            print("getting")
            return try viewContext.fetch(fetchRequest)
        }catch {
            print("Error saving location \(error.localizedDescription)")
            return []
        }
    }
    
    func deleteCity(city: City){
        let result = PersistenceController(inMemory: false)
        let viewContext = result.container.viewContext
        let fetchRequest: NSFetchRequest<LocationEntity> = LocationEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", "\(city.name)")
                    
                    do {
                       let data =  try viewContext.fetch(fetchRequest)
                         data.forEach { element in
                            viewContext.delete(element)
                        }
                        try viewContext.save()
                        
                    } catch{
                        print("Can't delete location \(error.localizedDescription)")
                    }
    }
}
