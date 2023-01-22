//
//  AddAccountView.swift
//  authenticator
//
//  Created by Tajima Yukito on 2023/01/22.
//

import Foundation
import SwiftUI
import CoreData

struct AddAccountView: View {
    
    @State
    var model = CodeModel()
    
    var onSave: (CodeModel) -> ()
    
    var body: some View {
        HStack {
            Form {
                TextField("Account", text: $model.name)
                TextField("Description", text: $model.desc)
                TextField("Key", text: $model.key)
            }
            .toolbar {
                ToolbarItem {
                    Button(action: save) {
                        Text("Save")
                    }.disabled(model.isDisabled)
                }
            }
            // clear the background color
            // .scrollContentBackground(.hidden)
            .navigationTitle("Edit account details")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private func save() {
        self.onSave(model)
    }
}


struct AddAccountView_Previews: PreviewProvider {

    static
    var codeModel = CodeModel(name: "",
                              desc: "",
                              key: dummyKey)
    
    static
    var previews: some View {
        AddAccountView(onSave: { _ in })
        //model: codeModel)
    }
}
