//
//  CoreDataViewModel.swift
//  authenticator
//
//  Created by Tajima Yukito on 2023/01/23.
//

import Foundation

class CodeDataViewModel: ObservableObject {
    @Published
    var items: [CodeModel] = []
    
    func fetchAll() -> [CodeModel] {
        CoreDataCodeItemModel.shared.fetchAll().map({ CodeModel(codeItem: $0) })
    }
    
    init() {
        items = fetchAll()
    }
    
    func add(_ model: CodeModel) {
        CoreDataCodeItemModel.shared.addItem(model)
        items = fetchAll()
    }
    
    func delete(id: Int64) {
        CoreDataCodeItemModel.shared.delete(id: id)
        items = fetchAll()
    }
    
    func edit(_ model: CodeModel, id: Int64) {
        CoreDataCodeItemModel.shared.edit(model, id: id)
        items = fetchAll()
    }
    
    ///  Sort the cordata id internally.
    ///  This function won't publish the change of items as it is edited on the frontend.
    ///  If it is updated here, it is redundant, and the UI would collapse.
    func sort() {
        CoreDataCodeItemModel.shared.sort(list: self.items)
    }
    
    func move(_ from: Int, _ to: Int) {
        CoreDataCodeItemModel.shared.move(from, to)
    }
}
