//
//  ContentView.swift
//  ChatBank
//
//  Created by Rishi Serumadar on 01/03/2020.
//  Copyright © 2020 NOSPACE. All rights reserved.
//

import SwiftUI
import NotificationCenter
import Alamofire

struct ContentView: View {
    
    @State var shownNewScreen = false
    @State var accountCreated = false
    @State var clientID = ""
    
    init(){
        UITableView.appearance().separatorColor = .clear
    }
    
    var body: some View {
        ZStack{
            if !shownNewScreen && !accountCreated{
                GettingStartedView()
            }else if shownNewScreen && !accountCreated && clientID == ""{
                PersonalSignupView()
            }else{
                Conversation(messages: [Message]())
            }
        }
        .animation(.spring())
        .onAppear {
            //Listeners
            NotificationCenter.default.addObserver(forName: NSNotification.Name("action=gotStarted"), object: nil, queue: nil) { (_) in
                self.shownNewScreen = true
            }
            
            NotificationCenter.default.addObserver(forName: NSNotification.Name("action=accountCreated"), object: nil, queue: nil) { (obj) in
                if let iid = obj.object as? String{
                    self.accountCreated = true
                    self.clientID = iid
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

