//
//  CoreDataCodeModel.swift
//  authenticator
//
//  Created by Tajima Yukito on 2023/01/23.
//

import Foundation
import CoreData

struct CoreDataCodeItemModel {
    
    static
    let shared = CoreDataCodeItemModel()
    
    private var context: NSManagedObjectContext {
        return PersistenceController.shared.container.viewContext
    }
    
    func fetchAll () -> [CodeItem] {
        let request = NSFetchRequest<CodeItem>(entityName: "CodeItem")
        request.sortDescriptors = [NSSortDescriptor(key: "id", ascending: false)]
        do {
            return try context.fetch(request)
        } catch {
            fatalError("CoreData fetch error: \(error)")
        }
    }
    
    func addItem(_ m: CodeModel) {
        let new = CodeItem(context: context)
        new.id = (fetchAll().first?.id ?? 0) + 1
        new.name = m.name
        new.desc = m.desc
        new.key = m.key
        
        do {
            try context.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    func deleteItem(id: Int64) {
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
    
    func editCodeItem(_ m: CodeModel, id: Int64) {
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
}
