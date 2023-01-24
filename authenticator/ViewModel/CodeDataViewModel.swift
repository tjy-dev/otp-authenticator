//
//  CoreDataViewModel.swift
//  authenticator
//
//  Created by Tajima Yukito on 2023/01/23.
//

import Foundation

class CodeDataViewModel: ObservableObject {
    @Published
    var items: [CodeItem] = []
    
    init() {
        items = CoreDataCodeItemModel.shared.fetchAll()
    }
    
    func add(_ model: CodeModel) {
        CoreDataCodeItemModel.shared.addItem(model)
        items = CoreDataCodeItemModel.shared.fetchAll()
    }
    
    func delete(id: Int64) {
        CoreDataCodeItemModel.shared.delete(id: id)
        items = CoreDataCodeItemModel.shared.fetchAll()
    }
    
    func edit(_ model: CodeModel, id: Int64) {
        CoreDataCodeItemModel.shared.edit(model, id: id)
        items = CoreDataCodeItemModel.shared.fetchAll()
    }
}
