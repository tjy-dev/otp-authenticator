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
    
    @Binding
    var from: CGFloat
    
    @Binding
    var to: CGFloat
    
    var body: some View {
        Circle()
            .fill(Color.clear)
            .frame(width: height, height: width)
            .overlay(
                Circle()
                    .rotation(Angle(degrees: -90))
                    .trim(from: from, to: to)
                    .stroke(style: StrokeStyle(
                        lineWidth: stroke,
                        lineCap: .round,
                        lineJoin:.round
                    ))
                    
            )
    }
    
}

struct ProgressPreview: PreviewProvider {

    @State static
    var from: CGFloat = 0

    @State static
    var to:   CGFloat = 0.5
    
    static
    var previews: some View {
        ProgressBar(height: 100, width: 100, stroke: 20, from: $from, to: $to)
    }

}
