//
//  ContentView.swift
//  authenticator
//
//  Created by Tajima Yukito on 2023/01/12.
//

import SwiftUI
import CoreData

/// Dummy key from
/// https://github.com/google/google-authenticator/wiki/Key-Uri-Format
/// check for more details.
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
                    VStack {
                        ForEach(codeViewModel.items, id: \.id) {
                            item in
                            CodeView(timerModel: timerModel,
                                     codeModel: CodeModel(codeItem: item),
                                     isEditing: $isEditing)
                            .onTapGesture {
                                if isEditing {
                                    navPath.append(item.id)
                                } else {
                                    let code = OTPCodeGenerator.generate(key: item.key!)
                                    UIPasteboard.general.string = code
                                }
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
                        ToolbarItem {
                            Menu {
                                Button(action: {
                                    navPath.append("add_account")
                                }) {
                                    Label("Enter setupkey", systemImage: "keyboard")
                                }
                                Button("Add dummy") {
                                    for _ in 0...5 {
                                        codeViewModel
                                            .addCodeItem(
                                                CodeModel(name: "Name",
                                                          desc: "name@example.com",
                                                          key: dummyKey)
                                            )
                                    }
                                }
                            } label: {
                                Label("Add Item", systemImage: "plus")
                            }
                        }
                    }
                }
                .navigationDestination(for: String.self, destination: { str in
                    if str == "add_account" {
                        AddAccountView { m in
                            codeViewModel.addCodeItem(m)
                            navPath = NavigationPath()
                        }
                    }
                })
                .navigationDestination(for: Int64.self, destination: { id in
                    if let first = codeViewModel.items.filter({ item in
                        item.id == id
                    }).first {
                        AddAccountView(model: CodeModel(codeItem: first)) { m in
                            codeViewModel.editCodeItem(m, id: id)
                            navPath = NavigationPath()
                        } onDelete: {
                            codeViewModel.deleteItem(id: id)
                            navPath = NavigationPath()
                        }
                    }
                })
                .onAppear {
                    isEditing = false
                }
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
