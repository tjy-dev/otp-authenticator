//
//  TimerViewModel.swift
//  authenticator
//
//  Created by Tajima Yukito on 2023/01/18.
//

import Foundation

struct TimeModel {
    
    var currentTime: Int
    
    init() {
        let date = Date.now
        let unixTime: TimeInterval = date.timeIntervalSince1970
        let unixTimeInt = Int(unixTime)
        self.currentTime = (30 - unixTimeInt % 30)
    }
    
    mutating func updateRemainingTime() {
        currentTime = generateRemainingTime()
    }
    
    func generateRemainingTime() -> Int {
        let date = Date.now
        let unixTime: TimeInterval = date.timeIntervalSince1970
        let unixTimeInt = Int(unixTime)
        return (30 - unixTimeInt % 30)
    }
}

class TimerViewModel: ObservableObject {
    
    @Published
    var model: TimeModel = TimeModel()
    
    var timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { _ in } )
    
    init() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { (timer) in
            self.model.updateRemainingTime()
        })
    }
}
