//
//  CoreDataCodeModel.swift
//  authenticator
//
//  Created by Tajima Yukito on 2023/01/23.
//

import Foundation
import CoreData

class CoreDataCodeItemModel: ObservableObject {
    
    static
    let shared = CoreDataCodeItemModel()
    
    private var context: NSManagedObjectContext {
        return PersistenceController.shared.container.viewContext
    }
    
    /// preview for Canvas preview.
    static var preview: CoreDataCodeItemModel = {
        let result = CoreDataCodeItemModel()
        // also works with result.context but it is the same thing.
        let viewContext = PersistenceController.shared.container.viewContext
        
        // remove older data for preview.
        // somehow it doesn't reload CoreData.
        let request = NSFetchRequest<CodeItem>(entityName: "CodeItem")
        request.sortDescriptors = [NSSortDescriptor(key: "order", ascending: false)]
        do {
            for item in try viewContext.fetch(request) {
                viewContext.delete(item)
            }
        } catch {
            fatalError("CoreData fetch error: \(error)")
        }
        
        // add dummy data for preview.
        for i in 1..<3 {
            let new = CodeItem(context: viewContext)
            new.id = Int64(i)
            new.order = Int64(i)
            new.name = "Code View " + String(new.id)
            new.desc = "name@example.com"
            new.key = dummyKey
        }
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()
    
    func fetchAll () -> [CodeItem] {
        let request = NSFetchRequest<CodeItem>(entityName: "CodeItem")
        request.sortDescriptors = [NSSortDescriptor(key: "order", ascending: false)]
        do {
            return try context.fetch(request)
        } catch {
            fatalError("CoreData fetch error: \(error)")
        }
    }
    
    func addItem(_ model: CodeModel) {
        let new = CodeItem(context: context)
        new.id = Int64(UUID().hashValue)
        new.order = (fetchAll().first?.order ?? 0) + 1
        new.name = model.name
        new.desc = model.desc
        new.key = model.key
        
        do {
            try context.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    func delete(id: Int64) {
        let item = fetchAll().filter { item in
            item.id == id
        }.first!
        
        context.delete(item)
        
        do {
            try context.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    func edit(_ m: CodeModel, id: Int64) {
        let item = fetchAll().filter { item in
            item.id == id
        }.first!
        item.name = m.name
        item.desc = m.desc
        item.key = m.key
        
        do {
            try context.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    func sort(list: [CodeModel]) {
        let items = fetchAll()
        let count = items.count
        
        items.enumerated().forEach { (i, item) in
            item.name = list[i].name
            item.id = list[i].id
            item.order = Int64(count - i)
            item.desc = list[i].desc
            item.key = list[i].key
        }

        do {
            try context.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}
