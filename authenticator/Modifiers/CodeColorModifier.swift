//
//  CodeColorModifier.swift
//  authenticator
//
//  Created by Tajima Yukito on 2023/01/21.
//

import Foundation
import SwiftUI


/// View extension for code color modifiers
/// Because sometimes isEditing is always false,
/// there are some of the extension for that.
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

/// modifier for forground
/// Because this set is used for most of the forground of the content
///
/// - Parameters:
///    - timermodel: TimerModel object
///    - isEditing: to idsable the color or not
///    
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
                        Color(.destructiveText)
            )
    }
}

/// Modifier for background
/// Because this set is used for most of the background of the content
///
/// - Parameters:
///    - timermodel: TimerModel object
///    - isEditing: to idsable the color or not
///
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
                        Color(.destructiveBackground)
            )
    }
}
