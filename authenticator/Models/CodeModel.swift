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


/// OTP code generator
/// Only has static method because there is no use of an instance
struct OTPCodeGenerator {
    
    /// Compute OTP code
    ///
    /// - Parameters:
    ///    - key: string key
    ///
    /// - Returns: String code of 6 digits e.g. "000000"
    ///
    static
    func computeCode (key: String) -> String {
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


/// Code model containing account information
///
/// - Parameters:
///    - name: name of account
///    - desc: description
///    - key: key for the account
///
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
    
    // For code validation
    var isDisabled: Bool {
        get {
            name.isEmpty ||
            desc.isEmpty ||
            key.isEmpty
        }
    }
    
    var name: String
    var desc: String
    var key : String
    
    // Generated code from self.key (computed)
    var code: String {
        get {
            OTPCodeGenerator.computeCode(key: key)
        }
    }
    
    // Code string split in to substring array
    var codeArray: Array<Substring> {
        get {
            Array((code.split(separator: "")))
        }
    }
    
    // Dummy code for isEditing mode
    // is Substring to match codeArray
    var dummyCode: Array<Substring> {
        get {
            ["•", "•", "•", "•", "•", "•"]
        }
    }
    
}
