//
//  TimerModel.swift
//  authenticator
//
//  Created by Tajima Yukito on 2023/01/19.
//

import Foundation

struct TimeModel {
    
    private
    var internalRemaningTime: Int
    
    /// Returns remaining time from 1...30 (doesn't include 0)
    var remainingTime: CGFloat {
        get { CGFloat(self.internalRemaningTime + 1) }
        set {}
    }
    
    init() {
        internalRemaningTime = TimeModel.generateinternalRemaningTime()
    }
    
    /// Returns: Unix-time interval from 1970.
    static
    func generateinternalRemaningTime() -> Int {
        // Because this is a general function acquireing Unixtime % 30,
        // it is a static method.
        let date = Date.now
        let unixTime: TimeInterval = date.timeIntervalSince1970
        let unixTimeInt = Int(unixTime)
        return (29 - unixTimeInt % 30)
    }

    /// Decrease the remaining time by 1 sec.
    mutating
    func decrement() {
        // (internalRemaningTime - 1) % 30 -> -1,
        // when internalRemaningTime == 0.
        // Thus adds 29 instead of subtracting 1.
        internalRemaningTime += 29
        internalRemaningTime %= 30
    }
}
