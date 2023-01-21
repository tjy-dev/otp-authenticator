//
//  ContentView.swift
//  authenticator
//
//  Created by Tajima Yukito on 2023/01/12.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \CodeItem.id, ascending: false)], animation: .default)
    private var codeItems: FetchedResults<CodeItem>

    @ObservedObject
    var timerModel = TimerViewModel()
    
    @State
    var codes = ["1", "2", "3", "4", "5", "6"]
    
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
        NavigationView {
            GeometryReader { geo in
                ScrollView {
                    VStack {
                        ForEach(codeItems, id: \.id) {
                            item in
                            CodeView(timerModel: timerModel, codeItem: item)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            EditButton()
                        }
                        ToolbarItem {
                            Button(action: addCodeItem) {
                                Label("Add Item", systemImage: "plus")
                            }
                        }
                    }
                }
                .navigationTitle("Authenticator")
                .background(Color(.background))
            }
        }
    }
    
    private func addCodeItem() {
        withAnimation {
            let new = CodeItem(context: viewContext)
            new.id = (codeItems.first?.id ?? 0) + 1
            new.name = "Code View"
            new.desc = "name@example.com"
            new.key = "123456"
            
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
