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
    var timerModel: TimerViewModel
    
    @Binding
    var codes: Array<String>
    
    var body: some View {
        HStack {
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text("Code View")
                            .font(.headline)
                        Text(verbatim: "name@example.com")
                            .font(.body)
                            .foregroundColor(Color(.secondaryLabel))
                    }
                    Spacer()
                    ProgressBar(stroke: 6, max: 30, to: $timerModel.model.remainingTime)
                        .foregroundColor(
                            Color(.highlightText)
                        )
                        .frame(width: 30, height: 30)
                }
                Spacer().frame(height: 15)
                HStack {
                    ForEach(codes, id: \.self) { c in
                        Text(c)
                            .font(Font.system(size: 30))
                            .frame(width: 40, height: 50)
                            .foregroundColor(Color(.highlightText))
                            .background(Color(.codeBackground))
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
    
    @State static
    var codes = ["1", "2", "3", "4", "5", "6"]
    
    static var previews: some View {
        ScrollView {
            CodeView(timerModel: timerModel, codes: $codes)
            CodeView(timerModel: timerModel, codes: $codes)
            Spacer()
        }.background(Color(.background))
    }
}
