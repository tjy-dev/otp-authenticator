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
        self.modifier(CodeBackgroundModifier(timerModel: timerModel, isEditing: false))
    }
    
    func background(timerModel: TimerViewModel, isEditing: Bool) -> some View {
        self.modifier(CodeBackgroundModifier(timerModel: timerModel, isEditing: isEditing))
    }
    
    func forground(timerModel: TimerViewModel) -> some View {
        self.modifier(CodeTextModifier(timerModel: timerModel, isEditing: false))
    }
    
    func forground(timerModel: TimerViewModel, isEditing: Bool) -> some View {
        self.modifier(CodeTextModifier(timerModel: timerModel, isEditing: isEditing))
    }
}


struct CodeTextModifier: ViewModifier {
    
    @ObservedObject
    var timerModel: TimerViewModel
    
    var isEditing: Bool
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(
                isEditing ?
                Color(.secondaryLabel) :
                    timerModel.model.remainingTime > 5.0 ?
                        Color(.highlightText) :
                        Color(.distructiveText)
            )
    }
}


struct CodeBackgroundModifier: ViewModifier {
    
    @ObservedObject
    var timerModel: TimerViewModel
    
    var isEditing: Bool
    
    func body(content: Content) -> some View {
        content
            .background(
                isEditing ?
                Color(.secondarySystemBackground) :
                    timerModel.model.remainingTime > 5.0 ?
                        Color(.codeBackground) :
                        Color(.distructiveBackground)
            )
    }
}
