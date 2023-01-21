//
//  CodeColorModifier.swift
//  authenticator
//
//  Created by Tajima Yukito on 2023/01/21.
//

import Foundation
import SwiftUI


extension View {
    func background(timerModel: TimerViewModel) -> some View {
        self.modifier(CodeBackgroundModifier(timerModel: timerModel))
    }
    
    func forground(timerModel: TimerViewModel) -> some View {
        self.modifier(CodeTextModifier(timerModel: timerModel))
    }
}


struct CodeTextModifier: ViewModifier {
    
    @ObservedObject
    var timerModel: TimerViewModel
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(
                timerModel.model.remainingTime > 5.0 ?
                Color(.highlightText) :
                    Color(.distructiveText)
            )
    }
}


struct CodeBackgroundModifier: ViewModifier {
    
    @ObservedObject
    var timerModel: TimerViewModel
    
    func body(content: Content) -> some View {
        content
            .background(
                timerModel.model.remainingTime > 5.0 ?
                Color(.codeBackground) :
                    Color(.distructiveBackground)
            )
    }
}
