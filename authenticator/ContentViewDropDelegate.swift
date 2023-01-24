//
//  ContentViewDropDelegate.swift
//  authenticator
//
//  Created by Tajima Yukito on 2023/01/24.
//

import Foundation
import SwiftUI

struct ContentViewDropDelegate: DropDelegate {
    let item: CodeModel
    @Binding var listData: [CodeModel]
    @Binding var current: CodeModel?
    
    @ObservedObject
    var codeViewModel: CodeDataViewModel

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