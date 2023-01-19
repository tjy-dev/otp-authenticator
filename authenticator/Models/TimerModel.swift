//
//  TimerModel.swift
//  authenticator
//
//  Created by Tajima Yukito on 2023/01/19.
//

import Foundation

struct TimeModel {
    
    var remainingTime: Int
    
    init() {
        remainingTime = TimeModel.generateRemainingTime()
    }
    
    // because this is a general function acquireing Unixtime % 30,
    // it is a static method.
    static
    func generateRemainingTime() -> Int {
        let date = Date.now
        let unixTime: TimeInterval = date.timeIntervalSince1970
        let unixTimeInt = Int(unixTime)
        return (30 - unixTimeInt % 30)
    }

    // this decreases the remaining time by 1 sec.
    // because (remainingTime - 1) % 30 would return
    // -1 when remainingTime == 0,
    // it adds 29 instead of subtracting 1.
    mutating
    func decrement() {
        remainingTime += 29
        remainingTime %= 30
    }
}
