//
//  ConfirmationView.swift
//  CalenderApp
//
//  Created by Ricky Villareal on 5/18/24.
//

import SwiftUI

struct ConfirmationView: View {
    var body: some View {
        VStack {
            Image("Ricky")
                .resizable()
                .scaledToFill()
                .frame(width:128, height: 128)
                .cornerRadius(64)
            
            Text("Confirmed")
                .font(.title)
                .bold()
                .padding()
            
            Text("You are scheduled with Ricky Villareal")
            
            Divider()
                .padding()
            
            VStack (alignment: .leading, spacing: 24){
                HStack{
                    Circle()
                        .frame(width: 28, height: 28)
                        .foregroundColor(.blue)
                    Text("iOS Dev 30 Min Session")
                }
                
                HStack{
                    Image(systemName: "calendar")
                    Text("time - time, Day, Month Day#, 2024")
                }
                
                HStack{
                    Image(systemName: "globe.americas")
                    Text("Pacific Standard Time - US % Canada")
                }
                
                HStack{
                    Image(systemName: "video")
                    Text("FaceTime")
                }
                
                Text("A calendar invitation has been sent to your email address. ")
                    .bold()
            }
            
            Divider()
            Spacer()
            
            Button{
                
            } label: {
                Text("Done")
                    .bold()
                    .padding()
                    .foregroundColor(.white)
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(.blue)
                    )
            }
            
        }
        .padding()
        .frame(maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .top)
    }
}

#Preview {
    NavigationStack{
        ConfirmationView()
    }
}
