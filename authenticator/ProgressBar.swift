//
//  ProgressBar.swift
//  authenticator
//
//  Created by Tajima Yukito on 2023/01/21.
//

import Foundation
import SwiftUI

/// A custom progress bar view.
///
/// - Parameters:
///    - max: maximum of `to`.
///    - to: `Binding<CGFloat>` value, end of stoke.
///    - stroke: width of stroke.
///
/// - Precondition:
///    - `to` must not be empty.
///
struct ProgressBar: View {
    
    var stroke: CGFloat = 15
    
    var max: CGFloat = 30
    
    @Binding
    var to: CGFloat
    
    var body: some View {
        Circle()
            .fill(.clear)
            .overlay(
                Circle()
                    .rotation(Angle(degrees: -90))
                    .trim(from: 0, to: to / max)
                    .stroke(style: StrokeStyle(
                        lineWidth: stroke,
                        lineCap: .round,
                        lineJoin: .round
                    ))
            )
    }
}

struct ProgressPreview: PreviewProvider {

    @State static
    var to: CGFloat = 10
    
    static
    var previews: some View {
        ProgressBar(stroke: 20, to: $to)
            .frame(width: 100, height: 100)
    }

}
