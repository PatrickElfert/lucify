//
//  LDAlarm.swift
//  Lucify (iOS)
//
//  Created by Patrick Elfert on 27.05.22.
//

import Foundation
import AVFoundation

public struct LDAlarm: Identifiable {
    init(date: Date, audioPlayer: AVAudioPlayer? = nil) {
        self.audioPlayer = audioPlayer
        self.date = date
        self.id = UUID()
        self.isCompleted = false
    }
    
    init(fromNow: TimeInterval) {
        self.date = Date.now.addingTimeInterval(fromNow)
        self.id = UUID()
        self.isCompleted = false
    }
    
    public var id: UUID
    var date: Date
    var audioPlayer: AVAudioPlayer?
    var isCompleted: Bool
}
