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
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \CodeItem.id, ascending: false)], animation: .default)
    private var codeItems: FetchedResults<CodeItem>

    // set editmode
    @State
    var isEditing: Bool = false

    @ObservedObject
    var timerModel = TimerViewModel()
    
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
                        ForEach(codeItems, id: \.id) {
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
                            } label: {
                                Label("Add Item", systemImage: "plus")
                            }
                        }
                    }
                }
                .navigationDestination(for: String.self, destination: { str in
                    if str == "add_account" {
                        AddAccountView { m in
                            addCodeItem(m)
                            navPath = NavigationPath()
                        }
                    }
                })
                .navigationDestination(for: Int64.self, destination: { id in
                    AddAccountView(model: CodeModel(codeItem: codeItems.filter({ item in
                        item.id == id
                    }).first!)) { m in
                        editCodeItem(m, id: id)
                        navPath = NavigationPath()
                    } onDelete: {
                        deleteItem(id: id)
                        navPath = NavigationPath()
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
    
    private func deleteItem(id: Int64) {
        withAnimation {
            let item = codeItems.filter { item in
                item.id == id
            }.first!
            viewContext.delete(item)
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    private func editCodeItem(_ m: CodeModel, id: Int64) {
        withAnimation {
            let item = codeItems.filter { item in
                item.id == id
            }.first!
            item.name = m.name
            item.desc = m.desc
            item.key = m.key
            
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    private func addCodeItem(_ m: CodeModel) {
        withAnimation {
            let new = CodeItem(context: viewContext)
            new.id = (codeItems.first?.id ?? 0) + 1
            new.name = m.name
            new.desc = m.desc
            new.key = m.key
            
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { codeItems[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
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
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
