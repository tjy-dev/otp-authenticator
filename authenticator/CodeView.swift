//
//  CodeView.swift
//  authenticator
//
//  Created by Tajima Yukito on 2023/01/18.
//

import Foundation
import SwiftUI

/// This is a code view that displays the account description, OTP code, and remaining time.
///
/// - Parameters:
///    - timerModel: TimerViewModel object for timer data.
///    - codeItem: CodeItem entity.
///
struct CodeView: View {
    
    @ObservedObject
    var timerModel: TimerViewModel
    
    var codeItem: CodeItem

    var body: some View {
        CodeViewContent(timerModel: timerModel,
                        codeModel: CodeModel(codeItem: codeItem))
    }
}
