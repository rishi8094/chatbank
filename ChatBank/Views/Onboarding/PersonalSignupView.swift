//
//  PersonalAccountView.swift
//  ChatBank
//
//  Created by Rishi Serumadar on 01/03/2020.
//  Copyright © 2020 NOSPACE. All rights reserved.
//

import Foundation
import SwiftUI
import Alamofire
import SwiftyJSON

struct PersonalSignupView: View {
    
    @State private var title = 0
    @State private var firstname: String = ""
    @State private var lastname: String = ""
    @State private var dob = Date()
    @State private var email: String = ""
    @State private var phone: String = ""
    @State private var account = 0
    
    @ObservedObject var keyboardResponder = KeyboardResponder()
    
    var body: some View {
        NavigationView{
            VStack{
                List{
                    Section{
                        Picker(selection: $title, label: Text("Title")) {
                            Text("Mr").tag(0)
                            Text("Mrs").tag(1)
                            Text("Miss").tag(2)
                        }.pickerStyle(SegmentedPickerStyle())
                        
                        TextField("Firstname", text: $firstname)
                        TextField("Lastname", text: $lastname)
                        DatePicker(selection: $dob, in: ...Date(), displayedComponents: .date) {
                            Text("Select a date")
                        }
                        
                    }
                    
                    Section{
                        TextField("Email", text: $email)
                        TextField("Phone", text: $phone)
                    }
                    
                    Section{
                        Picker(selection: $account, label: Text("Account Type")) {
                            Text("Current").tag(0)
                            Text("Savings").tag(1)
                        }.pickerStyle(SegmentedPickerStyle())
                    }
                }
                .listStyle(GroupedListStyle())
                .environment(\.horizontalSizeClass, .regular)
                .navigationBarTitle("Personal")
                
                Button(action: {
                    var title = "CUSTOMER_TITLE_MR"
                    if self.title == 1{
                        title = "CUSTOMER_TITLE_MRS"
                    }else if self.title == 2{
                        title = "CUSTOMER_TITLE_MISS"
                    }
                    
                    
                    
                    let params: Parameters = [
                        "personal":
                            ["title": title,
                             "firstname": self.firstname,
                             "lastname": self.lastname,
                             "dob": ["dd": "01", "mm": 02, "yyyy": 1994],
                             "nationality": "British",
                             "email": self.email,
                             "phone": self.phone
                        ],
                        "bank":[
                            "type": self.account == 0 ? "current_account" : "savings_account"
                        ]
                    ]
                    AF.request("https://25335041.eu.ngrok.io/create_customer", method: .post, parameters: params, encoding: JSONEncoding.default).response { response in
                        print(response.result)
                        switch response.result {
                        case .success(let value):
                            if let json = JSON(rawValue: value){
                                print(response.debugDescription)
//                                 NotificationCenter.default.post(name: NSNotification .Name("action=accountCreated"), object: String("ffff"))
                            }
                            
                        case.failure(let error):
                            print(error.localizedDescription)
                        }
                    }
                }) {
                    Text("Create Account")
                        .font(.system(size: 20))
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                    
                }
                .frame(width: 330, height:60)
                .background(Color(#colorLiteral(red: 0.1803921569, green: 0.1490196078, blue: 0.8509803922, alpha: 1)))
                .cornerRadius(10)
                Spacer()
            }
            
        }
        //        .keyboardResponsive()
    }
}

struct PersonalSignupView_Previews: PreviewProvider {
    static var previews: some View {
        PersonalSignupView ()
    }
}
