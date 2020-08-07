//
//  CoreDataManager.swift
//  WalkingRoutes
//
//  Created by Javier on 06/08/20.
//  Copyright © 2020 MrRobot. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager {
  static let shared = CoreDataManager()
  
  typealias SaveClousure = (_ error: Error?) -> Void
  typealias SaveRouteClousure = (_ route: Route?, _ error: Error?) -> Void
  
  lazy var persistentContainer = self.generatePersistentContainer()
  
  var operationsOnBackground = true
  
  // MARK: - Core Data stack
  
  var context: NSManagedObjectContext? {
    let context: NSManagedObjectContext?
    
    if self.operationsOnBackground {
      context = self.persistentContainer.newBackgroundContext()
    } else {
      context = self.persistentContainer.viewContext
    }
    
    context?.automaticallyMergesChangesFromParent = true
    
    return context
  }
  
  func generatePersistentContainer() -> NSPersistentContainer {
    let container = NSPersistentContainer(name: "WalkingRoutes")
    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    })
    return container
  }
  
  // MARK: - Core Data Saving support
  
  func saveContext(completionHandler: @escaping SaveClousure) {
    guard let context = self.context else {
      completionHandler(CoreDataError.cantGetContext)
      return
    }
    
    if context.hasChanges {
      let operation = {
        do {
          try context.save()
          completionHandler(nil)
        } catch let error {
          completionHandler(error)
        }
      }
      
      if self.operationsOnBackground {
        context.perform(operation)
      } else {
        context.performAndWait(operation)
      }
    } else {
      completionHandler(nil)
    }
  }
  
  func insertRoute(name: String,
                   distance: Double,
                   time: String) throws {
    guard let context = self.context else {
      throw CoreDataError.cantSave
    }
    let route = Route(context: context)
    route.name = name
    route.distance = distance
    route.time = time
    
    try context.save()
  }
  
  func fetchRoutes() throws -> [Route] {
    let request: NSFetchRequest<Route> = Route.fetchRequest()
    let results = try persistentContainer.viewContext.fetch(request)
    return results 
  }
  
  func delete(route: Route) {
    self.persistentContainer.viewContext.delete(route)
    saveContext { (error) in
      print(error.debugDescription)
    }
  }
  
}

enum CoreDataError: Error {
  case cantGetContext, cantSave
}
