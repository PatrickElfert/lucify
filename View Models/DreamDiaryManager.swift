//
//  DreamDiaryManager.swift
//  Lucify (iOS)
//
//  Created by Patrick Elfert on 07.06.22.
//

import Foundation

class DreamDiaryManager: ObservableObject {
    init() {}

    @Published var entries: [DiaryEntryModel] = []

    func addEntries(date: Date, newEntries: [DiaryEntryModel]) {
        newEntries.forEach { newEntry in
            let entryIndex = entries.firstIndex { $0.id == newEntry.id }
            if entryIndex != nil {
                entries[entryIndex!] = newEntry
            } else {
                entries.append(newEntry)
            }
        }
        if let encoded = try? JSONEncoder().encode(entries.map { DiaryEntryDTO(from: $0) }) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: getEntriesKey(date: date))
        }
    }

    func loadEntries(date: Date) {
        if let savedEntries = UserDefaults.standard.object(forKey: getEntriesKey(date: date)) as? Data,
           let loadedEntries = try? JSONDecoder().decode([DiaryEntryDTO].self, from: savedEntries)
        {
            entries = loadedEntries.map { DiaryEntryModel(from: $0) }
            return
        }
        entries = []
    }

    func getEntriesKey(date: Date) -> String {
        "entries\(date.toString(.isoDate)!)"
    }
}

struct DiaryEntryDTO: Encodable, Decodable, Identifiable {
    init(from: DiaryEntryModel) {
        id = UUID()
        date = from.date
        title = from.title
        description = from.description
        isLucid = from.isLucid
    }

    var date = Date.now
    var title = ""
    var description = ""
    var isLucid = false
    var id: UUID
}

struct DiaryEntryModel: Identifiable {
    init(date: Date, title: String, description: String, isLucid: Bool) {
        id = UUID()
        self.date = date
        self.title = title
        self.description = description
        self.isLucid = isLucid
    }

    init(preview _: Bool = true) {
        id = UUID()
        title = "Chocolate"
        description = "I was eating a lot of chocolate in my dream"
        isLucid = true
    }

    init(from: DiaryEntryDTO) {
        id = UUID()
        date = from.date
        title = from.title
        description = from.description
        isLucid = from.isLucid
    }

    var date = Date.now
    var title = ""
    var description = ""
    var isLucid = false
    var id: UUID
}
