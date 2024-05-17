//
//  BookingView.swift
//  CalenderApp
//
//  Created by Ricky Villareal on 5/16/24.
//

import SwiftUI

struct BookingView: View {
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Image(systemName: "clock")
                    Text("30 min")
                }
                
                HStack {
                    Image(systemName: "video")
                    Text("Facetime")
                }
                
                HStack {
                    Image(systemName: "calendar")
                    Text("time - time, date")
                }
                
                HStack {
                    Image(systemName: "globe")
                    Text("Pacific Time - US & Canada")
                }
            }
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .navigationTitle("Calendy Course")
    }
}

#Preview {
    NavigationStack{
        BookingView()
    }
}
