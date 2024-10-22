//
//  MeetingHeaderView.swift
//  Scrumdinger
//
//  Created by Abraham Guerrero on 10/21/24.
//

import SwiftUI
    
struct MeetingHeaderView: View {
    
    //Public variables are required when calling a view
    let secondsElapsed: Int
    let secondsRemaining: Int
    let theme: Theme
    
    // Private variables are not required when calling a view
    private var totalSeconds: Int {
        secondsElapsed + secondsRemaining
    }
    private var progress: Double {
        // Make sure totalSeconds is more than 0 to prevent division by 0
        guard totalSeconds > 0 else { return 1 }
        
        return Double(secondsElapsed) / Double(totalSeconds)
    }
    private var minutesRemaining: Int {
        secondsRemaining / 60
    }
    
    var body: some View {
        VStack {
            ProgressView(value: progress)
                .progressViewStyle(ScrumProgressViewStyle(theme: theme))
            HStack {
                VStack(alignment: .leading) {
                    Text("Seconds Elapsed")
                        .font(.caption)
                    Label("\(secondsElapsed)", systemImage: "hourglass.tophalf.fill")
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Text("Seconds Remaining")
                        .font(.caption)
                    Label("\(secondsRemaining)", systemImage: "hourglass.bottomhalf.fill")
                        .labelStyle(.trailingIcon)
                }
            }
            .accessibilityElement(children: .ignore)
            .accessibilityLabel("Time Remaining")
            .accessibilityValue("\(minutesRemaining) minutes")
            .padding([.top, .horizontal])
        }
    }
}
    
struct MeetingHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        MeetingHeaderView(secondsElapsed: 60, secondsRemaining: 180, theme: .orange)
            .previewLayout(.sizeThatFits) //Changes the default preview
    }
}
