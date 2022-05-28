//
//  LDAlarm.swift
//  Lucify (iOS)
//
//  Created by Patrick Elfert on 27.05.22.
//

import Foundation
import AVFoundation

struct LDAlarm: Identifiable {
    init(date: Date, audioPlayer: AVAudioPlayer? = nil) {
        self.audioPlayer = audioPlayer
        self.date = date
        self.id = UUID()
    }
    
    init(fromNow: TimeInterval) {
        self.date = Date.now.addingTimeInterval(fromNow)
        self.id = UUID()
    }
    
    var id: UUID
    var date: Date
    var audioPlayer: AVAudioPlayer?
}
