//
//  DreamDiaryManager.swift
//  Lucify (iOS)
//
//  Created by Patrick Elfert on 07.06.22.
//

import Foundation

class DreamDiaryManager {
    var entries: [DiaryEntryDTO] {
        set {
            if let encoded = try? JSONEncoder().encode(newValue) {
                let defaults = UserDefaults.standard
                defaults.set(encoded, forKey: "entries")
            }
        }
        get {
            if let savedEntries = UserDefaults.standard.object(forKey: "entries") as? Data,
               let loadedEntries = try? JSONDecoder().decode([DiaryEntryDTO].self, from: savedEntries) {
                return loadedEntries
            }
            return []
        }
    }
}

class DiaryEntryDTO: Encodable, Decodable {
    init(from: DiaryEntryModel) {
        date = from.date
        title = from.title
        description = from.description
        isLucid = from.isLucid}
    
    var date = Date.now
    var title = ""
    var description = ""
    var isLucid = false
}

class DiaryEntryModel: ObservableObject {
    @Published var date = Date.now
    @Published var title = ""
    @Published var description = ""
    @Published var isLucid = false
}
