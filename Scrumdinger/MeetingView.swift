//
//  ContentView.swift
//  Scrumdinger
//
//  Created by Abraham Guerrero on 10/20/24.
//

import SwiftUI
import AVFoundation

struct MeetingView: View {
    @Binding var scrum: DailyScrum
    
    // A StateObject property owns the source of truth for the ObservableObject
    // This means that this ScrumTimer is tied to the MeetingView
    @StateObject var scrumTimer = ScrumTimer()
    
    // Creates a player object with sharedDingPlayer (This file was brought in and it is not native)
    private var player: AVPlayer { AVPlayer.sharedDingPlayer }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16.0)
                .fill(scrum.theme.mainColor)
            VStack {
                MeetingHeaderView(secondsElapsed: scrumTimer.secondsElapsed,
                                  secondsRemaining: scrumTimer.secondsRemaining,
                                  theme: scrum.theme)
                Circle().strokeBorder(lineWidth: 24)
                MeetingFooterView(speakers: scrumTimer.speakers, skipAction: scrumTimer.skipSpeaker)
            }
        }
        .padding()
        .foregroundStyle(scrum.theme.accentColor)
        .onAppear {
            // The onAppear modifier calls a function whenever a view is rendered
            scrumTimer.reset(lengthInMinutes: scrum.lengthInMinutes,
                             attendees: scrum.attendees)
            scrumTimer.speakerChangedAction = {
                player.seek(to: .zero) // Ensures audio always plays from the beginning
                player.play()
            }
            scrumTimer.startScrum()
        }
        .onDisappear {
            // The onDisappear modifier calls a function whenever a view is unrendered
            scrumTimer.stopScrum()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct MeetingView_Previews: PreviewProvider {
    static var previews: some View {
        MeetingView(scrum: .constant(DailyScrum.sampleData[0]))
    }
}
