//
//  ContentView.swift
//  CalenderApp
//
//  Created by Ricky Villareal on 5/12/24.
//

import SwiftUI

struct MainView: View {
    
    let days = ["SUN", "MON", "TUE", "WED", "THUR", "FRI", "SAT"]
    
    @State var selectedMonth = 0
    @State var selectedDate = Date()
    
    var body: some View {
        VStack {
            Image("Ricky")
                .resizable()
                .scaledToFill()
                .frame(width: 128, height: 128)
                .cornerRadius(64.0)
            Text("Calender App")
                .font(.title)
                .bold()
            
            Rectangle()
                .frame(height: 1)
                .foregroundColor(.gray)
            
            VStack (spacing: 20){
                Text("Select a Day")
                    .font(.title2)
                    .bold()
                
                // Month Selection
                HStack {
                    Spacer()
                    
                    Button{
                        withAnimation {
                            selectedMonth -= 1
                        }
                        
                    } label: {
                        Image(systemName: "lessthan")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 16, height: 28)
                    }
                    
                    Spacer()
                    
                    Text(selectedDate.monthAndYear())
                        .font(.title2)
                    
                    Spacer()
                    
                    Button{
                        withAnimation {
                            selectedMonth += 1
                        }
                        
                    } label: {
                        Image(systemName: "greaterthan")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 16, height: 28)
                    }

                    
                    Spacer()

                }
                
                HStack {
                    ForEach(days, id:\.self) { day in
                        Text(day)
                            .font(.system(size: 12, weight: .medium))
                            .frame(maxWidth: .infinity)
                    }
                }
                
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 20) {
                    ForEach(fetchDates()) { value in
                        ZStack {
                            if value.day != -1 {
                                Text("\(value.day)")
                            } else {
                                Text("")
                            }
                        }
                        .frame(width: 32, height: 32)
                    }
                }
            }
            .padding()
        }
        .onChange(of: selectedMonth) {
                selectedDate = fetchSelectedMonth()
        }
    }
    
    func fetchDates() -> [CalendarDate] {
        let calendar = Calendar.current
        let currentMonth = fetchSelectedMonth()
        
        var dates = currentMonth.datesOfMonth().map({CalendarDate(day: calendar.component(.day, from: $0), date:$0)})
        
        let firstDayOfWeek = calendar.component(.weekday, from: dates.first?.date ?? Date())
        
        for _ in 0..<firstDayOfWeek - 1 {
            dates.insert(CalendarDate(day: -1, date: Date()), at: 0)
        }
        
        return dates
    }
    
    func fetchSelectedMonth() -> Date {
        let calendar = Calendar.current
        let month = calendar.date(byAdding: .month, value: selectedMonth, to: Date())
        
        return month!
    }
}

struct CalendarDate: Identifiable {
    let id = UUID()
    var day: Int
    var date: Date
}

extension Date {
    
    func monthAndYear() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM YYYY"
        
        return formatter.string(from: self)
    }
    
    func datesOfMonth() -> [Date] {
        let calendar = Calendar.current
        let currentMonth = calendar.component(.month, from: self)
        let currentYear = calendar.component(.year, from: self)
        
        var StartDateComponents = DateComponents()
        StartDateComponents.year = currentYear
        StartDateComponents.month = currentMonth
        StartDateComponents.day = 1
        let starDate = calendar.date(from: StartDateComponents)!
        
        var endDateComponents = DateComponents()
        endDateComponents.month = 1
        endDateComponents.day = -1
        let endDate = calendar.date(byAdding: endDateComponents, to: starDate)!
        
        var dates: [Date] = []
        var currentDate = starDate
        
        while currentDate <= endDate {
            dates.append(currentDate)
            currentDate = calendar.date(byAdding: .day, value: 1, to: currentDate)!
        }
        
        return dates
    }
}

#Preview {
    MainView()
}
