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
///    - codes: Array of String of codes. e.g. ["1", "2", "3", "4", "5", "6"]
///
struct CodeView: View {
    
    @ObservedObject
    var timerModel: TimerViewModel
    
    var codeItem: CodeItem

    var body: some View {
        HStack {
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text("Code View")
                            .font(.avenirBold())
                        Text(verbatim: "name@example.com id: \(codeItem.id)")
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
                    ForEach(Array((codeItem.key?.split(separator: ""))!), id: \.self) { c in
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

struct CodeView_Previews: PreviewProvider {
    @ObservedObject static
    var timerModel = TimerViewModel()
    
    static var previews: some View {
        ScrollView {
            // CodeView(timerModel: timerModel, codes: $codes)
            Spacer()
        }.background(Color(.background))
    }
}
