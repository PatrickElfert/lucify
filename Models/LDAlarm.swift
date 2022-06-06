//
//  LDAlarm.swift
//  Lucify (iOS)
//
//  Created by Patrick Elfert on 27.05.22.
//

import Foundation
import AVFoundation

public class LDAlarm: Identifiable, ObservableObject {
    init(date: Date, audioPlayer: AVAudioPlayer? = nil, id: UUID = UUID() ) {
        self.audioPlayer = audioPlayer
        self.date = date
        self.id = id
        self.isCompleted = false
    }
    
    init(fromNow: TimeInterval) {
        self.date = Date.now.addingTimeInterval(fromNow)
        self.id = UUID()
        self.isCompleted = false
    }
    
    @Published var isCompleted: Bool
    public var id: UUID
    var date: Date
    var audioPlayer: AVAudioPlayer?
}
