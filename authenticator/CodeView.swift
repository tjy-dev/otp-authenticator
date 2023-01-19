//
//  CodeView.swift
//  authenticator
//
//  Created by Tajima Yukito on 2023/01/18.
//

import Foundation
import SwiftUI

struct CodeView: View {
    
    @ObservedObject
    var timerModel = TimerViewModel()
    
    var body: some View {
        HStack {
            Text("Code View")
            Text("\(timerModel.model.remainingTime)")
        }
    }
}
