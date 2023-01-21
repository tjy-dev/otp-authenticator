//
//  CodeViewContent.swift
//  authenticator
//
//  Created by Tajima Yukito on 2023/01/22.
//

import Foundation
import SwiftUI

/// This is a code view that displays the account description, OTP code, and remaining time.
///
/// - Parameters:
///    - timerModel: TimerViewModel object for timer data.
///    - name: name of item
///    - desc: description of item
///    - code: String of codes. e.g. "123456"
///
struct CodeViewContent: View {
    
    @ObservedObject
    var timerModel: TimerViewModel
    
    var name: String
    
    var desc: String
    
    var code: String

    var body: some View {
        HStack {
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text(name)
                            .font(.avenirBold())
                        Text(verbatim: desc)
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
                    ForEach(Array((code.split(separator: ""))), id: \.self) { c in
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
    
    static var previews: some View {
        ScrollView {
            CodeViewContent(timerModel: timerModel, name: "Code View", desc: "name@example.com", code: "123456")
            CodeViewContent(timerModel: timerModel, name: "Code View", desc: "name@example.com", code: "123456")
            Spacer()
        }.background(Color(.background))
    }
}

