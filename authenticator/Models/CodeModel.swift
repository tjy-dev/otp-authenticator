//
//  CodeModel.swift
//  authenticator
//
//  Created by Tajima Yukito on 2023/01/18.
//

import Foundation
import CoreData
import SwiftBase32
import CryptoSwift

struct CodeModel {
    
    init(codeItem: CodeItem) {
        self.name = codeItem.name ?? ""
        self.desc = codeItem.desc ?? ""
        self.key  = codeItem.key ?? ""
    }
    
    init(name: String, desc: String, key: String) {
        self.name = name; self.desc = desc; self.key = key
    }

    init() {
        self.name = ""; self.desc = ""; self.key = ""
    }
    
    var name: String
    var desc: String
    var key : String
    var code: String {
        get {
            guard let key = base32Decode(key.replacingOccurrences(of: " ", with: "")) else {
                return "Error!"
            }
            
            let intervalTime = 30
            let date = Date.now
            let unixTime: TimeInterval = date.timeIntervalSince1970
            let unixTimeInt = Int(unixTime)
            let timeSteps = unixTimeInt / intervalTime
            
            let counter = withUnsafeBytes(of: timeSteps.bigEndian, Array.init)
            
            let hash = try! HMAC(key: key, variant: .sha1).authenticate(counter)
            
            let offset = Int(hash.last! & 0b00001111)
            
            var slicedHash = Array(hash[offset...offset+3])
            
            slicedHash[0] = slicedHash[0] & 0b01111111
            
            let num = Data(slicedHash).withUnsafeBytes { $0.load(as: UInt32.self).bigEndian }
            
            let top = String(num).suffix(6)
            
            return String(top)
        }
    }
    
}
