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
    
    init() {
        items = CoreDataCodeItemModel.shared.fetchAll().map({ CodeModel(codeItem: $0) })
    }
    
    func add(_ model: CodeModel) {
        CoreDataCodeItemModel.shared.addItem(model)
        items = CoreDataCodeItemModel.shared.fetchAll().map({ CodeModel(codeItem: $0) })
    }
    
    func delete(id: Int64) {
        CoreDataCodeItemModel.shared.delete(id: id)
        items = CoreDataCodeItemModel.shared.fetchAll().map({ CodeModel(codeItem: $0) })
    }
    
    func edit(_ model: CodeModel, id: Int64) {
        CoreDataCodeItemModel.shared.edit(model, id: id)
        items = CoreDataCodeItemModel.shared.fetchAll().map({ CodeModel(codeItem: $0) })
    }
}
