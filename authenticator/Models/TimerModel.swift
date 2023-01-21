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
    
    var remainingTime: CGFloat {
        get { CGFloat(self.internalRemaningTime + 1) }
        set {}
    }
    
    init() {
        internalRemaningTime = TimeModel.generateinternalRemaningTime()
    }
    
    // because this is a general function acquireing Unixtime % 30,
    // it is a static method.
    static
    func generateinternalRemaningTime() -> Int {
        let date = Date.now
        let unixTime: TimeInterval = date.timeIntervalSince1970
        let unixTimeInt = Int(unixTime)
        return (30 - unixTimeInt % 30)
    }

    // this decreases the remaining time by 1 sec.
    // because (internalRemaningTime - 1) % 30 would return
    // -1 when internalRemaningTime == 0,
    // it adds 29 instead of subtracting 1.
    mutating
    func decrement() {
        internalRemaningTime += 29
        internalRemaningTime %= 30
    }
}
