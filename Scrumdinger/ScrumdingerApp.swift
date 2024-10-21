//
//  ScrumdingerApp.swift
//  Scrumdinger
//
//  Created by Abraham Guerrero on 10/20/24.
//

import SwiftUI

@main
struct ScrumdingerApp: App {
    @State private var scrums = DailyScrum.sampleData
    
    var body: some Scene {
        WindowGroup {
            ScrumsView(scrums: $scrums)
        }
    }
}
