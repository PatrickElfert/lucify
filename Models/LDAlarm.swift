//
//  LDAlarm.swift
//  Lucify (iOS)
//
//  Created by Patrick Elfert on 27.05.22.
//

import AVFoundation
import Foundation

public class LDAlarm: Identifiable, ObservableObject {
    init(date: Date, audioPlayer: AVAudioPlayer? = nil, id: UUID = UUID()) {
        self.audioPlayer = audioPlayer
        self.date = date
        self.id = id
        isCompleted = false
    }

    init(fromNow: TimeInterval) {
        date = Date.now.addingTimeInterval(fromNow)
        id = UUID()
        isCompleted = false
    }

    @Published var isCompleted: Bool
    public var id: UUID
    var date: Date
    var audioPlayer: AVAudioPlayer?
}
