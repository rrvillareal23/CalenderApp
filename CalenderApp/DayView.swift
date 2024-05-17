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
    @State var selectedDate: Date?
    
    var body: some View {
        ScrollView {
            VStack {
                Text("May 16, 2024")
                
                Divider()
                    .padding(.vertical)
                
                Text("Select a Time")
                    .font(.largeTitle)
                    .bold()
                
                Text("Duration: 30 min")
                
                ForEach(dates, id: \.self) { date in
                    HStack {
                        Button{
                            withAnimation {
                                selectedDate = date
                            }
                        } label: {
                            Text(date.timeFromDate())
                                .bold()
                                .padding()
                                .frame(maxWidth: .infinity)
                                .foregroundColor(selectedDate == date ? .white : .blue)
                                .background(
                                    ZStack {
                                        if selectedDate == date {
                                            RoundedRectangle(cornerRadius: 10)
                                                .foregroundColor(.gray)
                                        } else {
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke()
                                        }
                                    }
                                )
                        }
                        
                        if selectedDate == date {
                            NavigationLink {
                                EmptyView()
                            } label: {
                                Text("Next")
                                    .bold()
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .foregroundColor(.white)
                                    .background(
                                        RoundedRectangle(cornerRadius: 10)
                                            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                                    )
                            }
                        }
                    }
                        
                }
                .padding(.horizontal)
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
