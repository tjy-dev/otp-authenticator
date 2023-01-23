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
    
    func addCodeItem(_ model: CodeModel) {
        CoreDataCodeItemModel.shared.addItem(model)
        items = CoreDataCodeItemModel.shared.fetchAll()
    }
    
    func deleteItem(id: Int64) {
        CoreDataCodeItemModel.shared.deleteItem(id: id)
        items = CoreDataCodeItemModel.shared.fetchAll()
    }
    
    func editCodeItem(_ m: CodeModel, id: Int64) {
        CoreDataCodeItemModel.shared.editCodeItem(m, id: id)
        items = CoreDataCodeItemModel.shared.fetchAll()
    }
}
