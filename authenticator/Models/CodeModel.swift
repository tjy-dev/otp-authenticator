//
//  CodeModel.swift
//  authenticator
//
//  Created by Tajima Yukito on 2023/01/18.
//

import Foundation
import CoreData

struct CodeModel {
    
    init(codeItem: CodeItem) {
        self.name = codeItem.name ?? "no name"
        self.desc = codeItem.desc ?? "no description"
        self.key  = codeItem.key ?? "no key"
    }
    
    init(name: String, desc: String, key: String) {
        self.name = name; self.desc = desc; self.key = key
    }
    
    var name: String
    var desc: String
    var key : String
    var code: String {
        get {
            return "123456"
        }
    }
    
}
