//
//  Helper.swift
//  Progetto Try
//
//  Created by Antonio Emanuele Cutarella on 15/11/21.
//

import Foundation

enum TimerMode {
    case running
    case paused
    case initial
    case timeIsUp
}

func secondsToMinutesAndSeconds(seconds: Int) -> String {
    let minutes = "\((seconds % 3600) / 60)"
    let seconds = "\((seconds % 3600) % 60)"
    let minuteStamp = minutes.count > 1 ? minutes : "0" + minutes
    let secondStamp = seconds.count > 1 ? seconds : "0" + seconds
    
    return "\(minuteStamp) : \(secondStamp)"
}
