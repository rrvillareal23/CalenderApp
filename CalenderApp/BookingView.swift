//
//  BookingView.swift
//  CalenderApp
//
//  Created by Ricky Villareal on 5/16/24.
//

import SwiftUI

struct BookingView: View {
    @State private var name = ""
    @State private var email = ""
    @State private var notes = ""

    var body: some View {
        VStack (alignment: .leading){
            VStack(alignment: .leading, spacing: 10) {
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
            
            Divider()
            
            VStack (alignment: .leading, spacing: 10){
                Text("Enter Details")
                    .font(.title)
                    .bold()
                
                Text("Name")
                TextField("", text: $name)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke()
                    )
                
                Text("Email")
                TextField("", text: $email)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke()
                    )
                
                Text("Please share anything that will help prepare for our meeting.")
                TextField("", text: $notes, axis: .vertical)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke()
                    )
                
                Spacer()

                NavigationLink {
                        EmptyView()
                    } label: {
                        Text("Schedule Event")
                            .bold()
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundColor(.blue)
                            )
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
