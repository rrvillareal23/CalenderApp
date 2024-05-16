//
//  DayView.swift
//  CalenderApp
//
//  Created by Ricky Villareal on 5/14/24.
//

import SwiftUI

struct DayView: View {
    
    @State var dates = [
        Date(),
        Calendar.current.date(byAdding: .hour, value: 1, to: Date())!,
        Calendar.current.date(byAdding: .hour, value: 2, to: Date())!,
        Calendar.current.date(byAdding: .hour, value: 3, to: Date())!,
        Calendar.current.date(byAdding: .hour, value: 4, to: Date())!,
    ]
    var body: some View {
        ScrollView {
            VStack {
                Text("May 15, 2024")
                
                Divider()
                    .padding(.vertical)
                
                Text("Select a Time")
                    .font(.largeTitle)
                    .bold()
                
                Text("Duration: 30 min")
                
                ForEach(dates, id: \.self) { date in
                    Button{
                        
                    } label: {
                        Text(date.timeFromDate())
                            .padding()
                    }
                }
            }
        }
        .navigationTitle("Wednesday")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack{
        DayView()
    }
}
