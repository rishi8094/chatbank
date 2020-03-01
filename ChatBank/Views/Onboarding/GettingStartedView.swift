//
//  AccountRegister.swift
//  ChatBank
//
//  Created by Rishi Serumadar on 01/03/2020.
//  Copyright © 2020 NOSPACE. All rights reserved.
//

import Foundation
import SwiftUI


struct GettingStartedView: View {
    var body: some View {
        Color(.white)
            .edgesIgnoringSafeArea(.vertical)
            .overlay(
                VStack{
                    Spacer()
                    Image("space")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .position(x: 150, y: 130)
                        .frame(width: 300, height: 250)
                        .clipped()
                        .padding(.bottom, 40)
                    Text("A futuristic mobile banking chat based service")
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                        .lineLimit(2)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                        .padding(.bottom, 20)
                    Text("Take control of when and how you can achieve financial freedom")
                        .foregroundColor(Color(#colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6274509804, alpha: 1)))
                    .font(.system(size: 15))
                    .lineLimit(3)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    Button(action: {
                        NotificationCenter.default.post(name: NSNotification.Name("action=gotStarted"), object: nil)
                    }) {
                        Text("Get Started")
                            .font(.system(size: 20))
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            
                    }
                    .frame(width: 330, height:60)
                    .background(Color(#colorLiteral(red: 0.1803921569, green: 0.1490196078, blue: 0.8509803922, alpha: 1)))
                    .cornerRadius(10)
                    Spacer()
                }
        )
    }
}

struct GettingStartedView_Previews: PreviewProvider {
    static var previews: some View {
        GettingStartedView()
    }
}
