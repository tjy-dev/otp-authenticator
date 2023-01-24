//
//  ContentView.swift
//  authenticator
//
//  Created by Tajima Yukito on 2023/01/12.
//

import SwiftUI
import CoreData

// Dummy key from
// - https://github.com/google/google-authenticator/wiki/Key-Uri-Format
// Check link for more details.
let dummyKey = "HXDMVJECJJWSRB3HWIZR4IFUGFTMXBOZ"

struct ContentView: View {
    
    // Not using due to use of view model.
    // @Environment(\.managedObjectContext) private var viewContext

    // set editmode
    @State
    var isEditing: Bool = false

    @ObservedObject
    var timerModel = TimerViewModel()
    
    @ObservedObject
    var codeViewModel = CodeDataViewModel()
    
    @State private
    var navPath = NavigationPath()
    
    init() {
        // set navigatino bar title attributes
        // e.g. custom fonts
        UINavigationBar.appearance().titleTextAttributes = [
            .font: UIFont.avenirDemiBold(20)
        ]
        UINavigationBar.appearance().largeTitleTextAttributes = [
            .font: UIFont.avenirBold(30)
        ]
    }
    
    var body: some View {
        NavigationStack(path: $navPath) {
            GeometryReader { geo in
                ScrollView {
                    ForEach(codeViewModel.items, id: \.id) { item in
                        CodeView(timerModel: timerModel,
                                 codeModel: item,
                                 isEditing: $isEditing)
                        .onTapGesture {
                            if isEditing {
                                navPath.append(item.id)
                            } else {
                                let code = OTPCodeGenerator.generate(key: item.key)
                                UIPasteboard.general.string = code
                            }
                        }
                    }
                    .padding(.bottom, 20)
                    .frame(maxWidth: .infinity)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(isEditing ? "Done" : "Edit") {
                                isEditing.toggle()
                            }
                        }
#if DEBUG
                        ToolbarItem {
                            Button("Dummy") {
                                codeViewModel.add(CodeModel.dummy)
                            }
                        }
#endif
                        ToolbarItem {
                            Menu {
                                Button {
                                    navPath.append("add_account")
                                } label: {
                                    Label("Enter setupkey", systemImage: "keyboard")
                                }
                            } label: {
                                Label("Add Item", systemImage: "plus")
                            }
                        }
                    }
                }
                .navigationDestination(for: String.self, destination: { str in
                    if str == "add_account" {
                        AddAccountView { model in
                            codeViewModel.add(model)
                            navPath = NavigationPath()
                        }
                    }
                })
                .navigationDestination(for: Int64.self, destination: { id in
                    if let item = codeViewModel.items.filter({ $0.id == id }).first {
                        AddAccountView(model: item) { model in
                            codeViewModel.edit(model, id: id)
                            navPath = NavigationPath()
                        } onDelete: {
                            codeViewModel.delete(id: id)
                            navPath = NavigationPath()
                        }
                    }
                })
                .onAppear { isEditing = false }
                .navigationTitle("Authenticator")
                .background(Color(.background))
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(CoreDataCodeItemModel.preview)
        // https://ios-docs.dev/swiftui-environmentobject/
        // Returns a new CoreDataCodeItemModel instance.
        
        // Preview crashes with this below.
        // .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        // \. is givin the keyPath to `struct Environment`
        // https://ios-docs.dev/swiftui-environment/
    }
}
