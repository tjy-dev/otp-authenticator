//
//  TimerViewModel.swift
//  authenticator
//
//  Created by Tajima Yukito on 2023/01/18.
//

import Foundation

class TimerViewModel: ObservableObject {
    
    @Published
    var model: TimeModel = TimeModel()
    
    var timer: Timer!
    
    init() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { [self] _ in
            model.decrement()
        })
    }
}
