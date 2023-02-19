//
//  GridViewSample.swift
//  authenticator
//
//  Created by Tajima Yukito on 2023/01/24.
//

import Foundation
import SwiftUI
import UniformTypeIdentifiers


struct GridViewSample: View {
    
    @State
    var items: [CodeModel]
    
    init() {
        
        var dummies: [CodeModel] = []
        var item0 = CodeModel.dummy
        item0.id = 0
        item0.name = "Item 0"
        dummies.append(item0)
        
        var item1 = CodeModel.dummy
        item1.id = 1
        item1.name = "Item 1"
        dummies.append(item1)
        
        var item2 = CodeModel.dummy
        item2.id = 2
        item2.name = "Item 2"
        dummies.append(item2)
        
        items = dummies
    }
    
    @State
    var selected: CodeModel?
    
    var body: some View {
        VStack {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: .infinity))]) {
                Text(selected?.name ?? "none")
                ForEach(items, id: \.id) { item in
                    HStack {
                        Text("id: \(item.id)")
                        Text(item.name)
                        Text(item.desc)
                    }
                    .padding(.all, 10)
                    // .opacity(selected == item ? 0 : 1)
                    .onDrag {
                        self.selected = item
                        // return NSItemProvider(item: nil, typeIdentifier: item)
                        return NSItemProvider(object: String(item.id) as NSString)
                    }
                    .onDrop(of: [UTType.text], delegate: DragRelocateDelegate(item: item, listData: $items, current: $selected))
                    .animation(.default, value: items)
                }
            }
            Spacer().frame(height: 100)
        }
        .background(Color.blue)
    }
}

struct DragRelocateDelegate: DropDelegate {
    let item: CodeModel
    @Binding var listData: [CodeModel]
    @Binding var current: CodeModel?

    func dropEntered(info: DropInfo) {
        if item != current {
            let from = listData.firstIndex(of: current!)!
            let to = listData.firstIndex(of: item)!
            if listData[to].id != current!.id {
                listData.move(fromOffsets: IndexSet(integer: from),
                    toOffset: to > from ? to + 1 : to)
            }
        }
    }
    
    func dropUpdated(info: DropInfo) -> DropProposal? {
        return DropProposal(operation: .move)
    }

    func performDrop(info: DropInfo) -> Bool {
        self.current = nil
        return true
    }
}

struct GridView_PreviewProvider: PreviewProvider {
    
    static
    var previews: some View {
        GridViewSample()
    }
}

