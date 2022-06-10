//
//  TimerManager.swift
//  Progetto Try
//
//  Created by Antonio Emanuele Cutarella on 15/11/21.
//

import Foundation
import SwiftUI

class TimerManager: ObservableObject {
    
    @Published var timerMode: TimerMode = .initial
    
    @Published var secondsLeft = UserDefaults.standard.integer(forKey: "timerLength")
    
    @Published var timeIsUp : Bool = false
    
    var timer = Timer()
    
    func setTimerLength(minutes: Int) {
        let defaults = UserDefaults.standard
        defaults.set(minutes, forKey: "timerLength")
        secondsLeft = minutes
    }
    
    func start() {
        self.timeIsUp = false
        timerMode = .running
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { timer in
            self.secondsLeft -= 1
            
            if self.secondsLeft == -1 {
                self.timeIsUp = true
                self.reset()
            }
        })
    }
    
    func reset() {
        self.timerMode = .initial
        self.secondsLeft = UserDefaults.standard.integer(forKey: "timerLength")
        timer.invalidate()
    }
    
    func pause() {
        self.timerMode = .paused
        timer.invalidate()
    }
}
