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
        NavigationStack{
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
                            Image(systemName: "lessthan.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 32, height: 32)
                                .foregroundColor(.gray)
                        }
                        
                        Spacer()
                        
                        Text(selectedDate.monthYearFormat())
                            .font(.title2)
                        
                        Spacer()
                        
                        Button{
                            withAnimation {
                                selectedMonth += 1
                            }
                        } label: {
                            Image(systemName: "greaterthan.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 32, height: 32)
                                .foregroundColor(.gray)

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
                                    NavigationLink{
                                        DayView(currentDate: value.date)
                                    } label: {
                                            Text("\(value.day)")
                                                .foregroundColor(value.day % 2 != 0 ? .blue : .black)
                                                .fontWeight(value.day % 2 != 0 ? .bold : .none)

                                                .background{
                                                    ZStack (alignment: .bottom) {
                                                        Circle()
                                                            .frame(width: 48, height: 48)
                                                            .foregroundColor(value.day % 2 != 0 ? .blue.opacity(0.3) : .clear)
                                                        
                                                        
                                                        if value.date.monthDayYearFormat() == Date().monthDayYearFormat() {
                                                            Circle()
                                                                .frame(width: 8, height: 8)
                                                                .foregroundColor(value.day % 2 != 0 ? .blue : .gray)

                                                        }
                                                    }
                                                }
                                        }
                                    .disabled(value.day % 2 == 0)
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
            .frame(maxHeight: .infinity, alignment: .top)
            .onChange(of: selectedMonth) {
                    selectedDate = fetchSelectedMonth()
            }
            .task {
                do {
                    _ = try await DatabaseManager.shared.fetchHours()
                } catch {
                    print(error.localizedDescription)
                }
            }

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
    
    // Returns May 2024
    func monthYearFormat() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM YYYY"
        
        return formatter.string(from: self)
    }
    
    // Retruns 05/18/2024
    func monthDayYearFormat() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter.string(from: self)
    }
    
    // Returns  May 18, 2024
    func fullMonthDayYearFormat() -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d, YYYY"
        return formatter.string(from: self)
    }
    
    // Day of the week
    func dayOfTheWeek() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        return formatter.string(from: self)
    }
    
    // Returns 10:10 AM
    func timeFromDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        return formatter.string(from: self)
    }
    
    func bookingViewDateFormat() -> String {
        
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "hh:mm a"
        
        let start = timeFormatter.string(from: self)
        let endDate = Calendar.current.date(byAdding: .minute, value: 30, to: self)!
        
        let end = timeFormatter.string(from: endDate)
        
        let day = self.dayOfTheWeek()
        
        let fullDayString = self.fullMonthDayYearFormat()
        
        return "\(start) - \(end), \(day), \(fullDayString)"
        
    }
}

#Preview {
    MainView()
}
