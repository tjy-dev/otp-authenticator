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
    
    var onDelete: (() -> ())?
    
    // alert presentation
    @State
    var isPresented = false

    var body: some View {
        VStack {
            Form {
                Section {
                    TextField("Account", text: $model.name)
                    TextField("Description", text: $model.desc)
                        .keyboardType(.emailAddress)
                        .autocorrectionDisabled(true)
                        .textInputAutocapitalization(TextInputAutocapitalization(.none))
#if DEBUG
                    TextField("Key", text: $model.key)
                        .disabled(false)
                        .foregroundColor(.secondary)
#endif
                }
                Section {
                    if onDelete != nil {
                        Button("Delete", role: .destructive, action: {
                            isPresented.toggle()
                        })
                        .alert(isPresented: $isPresented) {
                            Alert(title: Text("Are you sure?"),
                                  primaryButton: .destructive(Text("Delete"), action: {
                                      delete()
                                  }),
                                  secondaryButton: .cancel())
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem {
                    Button(action: save) {
                        Text("Save")
                    }.disabled(model.isDisabled)
                }
            }
        }
        // clear the background color
        // .scrollContentBackground(.hidden)
        .navigationTitle("Edit account details")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func save() {
        self.onSave(model)
    }
    
    private func delete() {
        if let onDelete = self.onDelete {
            onDelete()
        }
    }
}


struct AddAccountView_Previews: PreviewProvider {

    static
    var codeModel = CodeModel(name: "Name",
                              desc: "Description",
                              key: dummyKey)
    
    static
    var previews: some View {
        VStack {
            AddAccountView(onSave: { _ in })
            AddAccountView(model: codeModel, onSave: { _ in }, onDelete: {})
        }
    }
}
