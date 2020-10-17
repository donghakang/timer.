//
//  File.swift
//  Moving Arc
//
//  Created by Dongha Kang on 2020/10/17.
//

import Foundation

class customTime {
    static func toTime(t: Int) -> String {
        var time: Int = t
        let ms = time % 100
        time = Int(time / 100)
        let s  = time % 100
        time = Int(time / 60)
        let m  = time % 60
        time = Int(time / 60)
        let h  = time % 60
        
        var returnString: String
        returnString = String(format: "%02d", h) + ":"
        returnString += String(format: "%02d", m) + ":"
        returnString += String(format: "%02d", s) + ":"
        returnString += String(format: "%02d", ms)
        
        return returnString
    }
}
