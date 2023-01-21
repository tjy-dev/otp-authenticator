//
//  ProgressBar.swift
//  authenticator
//
//  Created by Tajima Yukito on 2023/01/21.
//

import Foundation
import SwiftUI

struct ProgressBar: View {
    
    var height: CGFloat = 100
    var width:  CGFloat = 100
    var stroke: CGFloat = 15
    
    var max: CGFloat = 30
    
    @Binding
    var to: CGFloat
    
    var body: some View {
        Circle()
            .fill(Color.clear)
            .frame(width: height, height: width)
            .overlay(
                Circle()
                    .rotation(Angle(degrees: -90))
                    .trim(from: 0, to: to / max)
                    .stroke(style: StrokeStyle(
                        lineWidth: stroke,
                        lineCap: .round,
                        lineJoin:.round
                    ))
                    .foregroundColor(Color(.highlightText))
            )
    }
}

struct ProgressPreview: PreviewProvider {

    @State static
    var to: CGFloat = 10
    
    static
    var previews: some View {
        ProgressBar(height: 100, width: 100, stroke: 20, to: $to)
    }

}
