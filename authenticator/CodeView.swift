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
///    - codeModel: CodeModel object containing attributes.
///
struct CodeView: View {
    
    @ObservedObject
    var timerModel: TimerViewModel
    
    var codeModel: CodeModel
    
    @Binding
    var isEditing: Bool

    var body: some View {
        HStack {
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text(codeModel.name)
                            .font(.avenirBold())
                        Text(verbatim: codeModel.desc)
                            .font(.avenir())
                            .foregroundColor(Color(.secondaryLabel))
                    }
                    Spacer()
                    ProgressBar(stroke: 6, max: 30, to: $timerModel.model.remainingTime)
                        .forground(timerModel: timerModel)
                        .frame(width: 30, height: 30)
                }
                Spacer().frame(height: 15)
                HStack {
                    ForEach(isEditing ? codeModel.dummyCode : codeModel.codeArray,  id: \.self) { c in
                        Text(c)
                            .forground(timerModel: timerModel)
                            .font(.avenirBold(30))
                            .frame(width: 40, height: 45)
                            .foregroundColor(Color(.highlightText))
                            .background(timerModel: timerModel)
                            .cornerRadius(10)
                    }
                    Spacer()
                }
            }
            .padding(.all, 20)
            .background(Color(.contentBackground))
            .cornerRadius(20)
        }
        .padding(.horizontal, 15)
        .padding(.top, 10)
    }
}

struct CodeViewContent_Previews: PreviewProvider {
    @ObservedObject static
    var timerModel = TimerViewModel()
    
    static
    var codeModel = CodeModel(name: "Code View",
                              desc: "name@example.com",
                              key: dummyKey)
    
    @State static
    var isEditing = false
    
    static var previews: some View {
        ScrollView {
            CodeView(timerModel: timerModel, codeModel: codeModel, isEditing: $isEditing)
            CodeView(timerModel: timerModel, codeModel: codeModel, isEditing: $isEditing)
            Spacer()
        }.background(Color(.background))
    }
}

