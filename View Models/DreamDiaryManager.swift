//
//  DreamDiaryManager.swift
//  Lucify (iOS)
//
//  Created by Patrick Elfert on 07.06.22.
//

import Foundation

class DreamDiaryManager: ObservableObject {
    init() {}

    init(entries: [DiaryEntryDTO]) {
        self.entries = entries
    }

    func getFilteredEntries(date: Date) -> [DiaryEntryDTO] {
        entries.filter {
            Calendar.current.isDate($0.date, equalTo: date, toGranularity: .day)
        }
    }

    var entries: [DiaryEntryDTO] {
        set {
            if let encoded = try? JSONEncoder().encode(newValue) {
                let defaults = UserDefaults.standard
                defaults.set(encoded, forKey: "entries")
            }
        }
        get {
            if let savedEntries = UserDefaults.standard.object(forKey: "entries") as? Data,
               let loadedEntries = try? JSONDecoder().decode([DiaryEntryDTO].self, from: savedEntries)
            {
                print(loadedEntries)
                return loadedEntries
            }
            return []
        }
    }
}

class DiaryEntryDTO: Encodable, Decodable, Identifiable {
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

class DiaryEntryModel: ObservableObject {
    init(date: Date, title: String, description: String, isLucid: Bool) {
        self.date = date
        self.title = title
        self.description = description
        self.isLucid = isLucid
    }

    init(preview _: Bool = true) {
        title = "Chocolate"
        description = "I was eating a lot of chocolate in my dream"
        isLucid = true
    }

    init(from: DiaryEntryDTO) {
        date = from.date
        title = from.title
        description = from.description
        isLucid = from.isLucid
    }

    @Published var date = Date.now
    @Published var title = ""
    @Published var description = ""
    @Published var isLucid = false
}
