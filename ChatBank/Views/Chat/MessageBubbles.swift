//
//  MessageBubbles.swift
//  ChatBank
//
//  Created by Rishi Serumadar on 01/03/2020.
//  Copyright © 2020 NOSPACE. All rights reserved.
//

import Foundation
import SwiftUI

struct BotMessage: View{
    var message: Message
    
    var body: some View {
        HStack(){
            Image("botpfp")
                .resizable()
                .frame(width: 50)
                .frame(height: 50)
                .cornerRadius(50)
            Text("\(message.content)")
                .foregroundColor(Color(#colorLiteral(red: 0.3607843137, green: 0.3921568627, blue: 0.4470588235, alpha: 1)))
                .padding(.horizontal, 10)
                .padding(.vertical, 10)
                .background(RoundedCorners(color: .white, tl: 20, tr: 30, bl: 10, br: 30))
                .cornerRadius(10)
                .shadow(color: Color(UIColor(displayP3Red: 0.00, green:0.00, blue:0.00, alpha: 0.31)), radius: 6, x: 0, y: 3)
        }
        .frame(maxWidth: 330, alignment: .leading)
    }
}

struct HumanMessage: View{
    var message: Message
    
    var body: some View {
        HStack(){
            Text("\(message.content)")
                .foregroundColor(Color(#colorLiteral(red: 0.3607843137, green: 0.3921568627, blue: 0.4470588235, alpha: 1)))
                .padding(.horizontal, 10)
                .padding(.vertical, 10)
                .background(RoundedCorners(color: .white, tl: 30, tr: 10, bl: 30, br: 20))
                .cornerRadius(10)
                .shadow(color: Color(UIColor(displayP3Red: 0.00, green:0.00, blue:0.00, alpha: 0.31)), radius: 6, x: 0, y: 3)
            Image("userpfp")
                .resizable()
                .frame(width: 50)
                .frame(height: 50)
                .cornerRadius(50)
        }
        .frame(maxWidth: 330, alignment: .trailing)
    }
}

