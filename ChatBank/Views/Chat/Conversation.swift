//
//  Conversation.swift
//  ChatBank
//
//  Created by Rishi Serumadar on 01/03/2020.
//  Copyright © 2020 NOSPACE. All rights reserved.
//

import Foundation
import SwiftUI
import PartialSheet
import CoreLocation
import MapKit
import Alamofire
import SwiftyJSON

struct Conversation: View{
    @ObservedObject private var keyboard = KeyboardResponder()
    @State var messages: [Message]
    @State var composedMessage = ""
    
    @State var buttonOption1 = "Balance?"
    @State var buttonOption2 = "Unknown Charge?"
    @State var buttonOption3 = "ATM's?"
    
    @State var showModalView = false
    @State var modalViewType:ModalType = .map
    
    @State var modalMap:MapView?
    
    var body: some View{
        NavigationView{
            VStack{
                VStack{
                    List{
                        ForEach(self.messages) { message in
                            if message.senderType == .bot{
                                BotMessage(message: message)
                            }else{
                                HumanMessage(message: message)
                            }
                        }
                    }
                }
                VStack{
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack{
                            Button(action: {
                                self.sendMessage(content: self.buttonOption1, predicted: true)
                            }) {
                                Text(buttonOption1)
                                    .foregroundColor(.white)
                                    .padding(.horizontal)
                                    .padding(.vertical, 5)
                                    .background(Color(#colorLiteral(red: 0.1803921569, green: 0.1490196078, blue: 0.8509803922, alpha: 1)))
                                    .cornerRadius(7)
                                    .clipped()
                            }
                            .padding(.leading, 20)
                            
                            Button(action: {
                                self.sendMessage(content: self.buttonOption2, predicted: true)
                            }) {
                                Text(buttonOption2)
                                    .foregroundColor(.white)
                                    .padding(.horizontal)
                                    .padding(.vertical, 5)
                                    .background(Color(#colorLiteral(red: 0.1803921569, green: 0.1490196078, blue: 0.8509803922, alpha: 1)))
                                    .cornerRadius(7)
                                    .clipped()
                            }
                            
                            Button(action: {
                                self.sendMessage(content: self.buttonOption3, predicted: true)
                            }) {
                                Text(buttonOption3)
                                    .foregroundColor(.white)
                                    .padding(.horizontal)
                                    .padding(.vertical, 5)
                                    .background(Color(#colorLiteral(red: 0.1803921569, green: 0.1490196078, blue: 0.8509803922, alpha: 1)))
                                    .cornerRadius(7)
                                    .clipped()
                            }
                            .padding(.trailing, 20)
                        }
                    }
                    HStack {
                        // this textField generates the value for the composedMessage @State var
                        TextField("Message...", text: $composedMessage).frame(minHeight: CGFloat(30))
                            .padding(.horizontal)
                            .padding(.vertical, 5)
                            .background(Color(#colorLiteral(red: 0.8666666667, green: 0.8666666667, blue: 0.8666666667, alpha: 1)))
                            .cornerRadius(10)
                        // the button triggers the sendMessage() function written in the end of current View
                        Button(action: {
                            self.sendMessage(content: self.composedMessage, predicted: false)
                            self.composedMessage = ""
                        }) {
                            Text("Send")
                                .foregroundColor(.white)
                                .padding(.horizontal)
                                .padding(.vertical, 5)
                                .background(Color.blue)
                                .cornerRadius(15)
                                .clipped()
                        }
                    } .padding(.horizontal)
                }
                .frame(minHeight: CGFloat(50))
                .padding(.bottom, keyboard.currentHeight)
                .edgesIgnoringSafeArea(keyboard.currentHeight == 0.0 ? .leading: .bottom)
            }.onAppear(perform: {
                self.messages.append(Message(stype: .bot, mtype: .text, content: "Hey, how can I help?"))
            })
                .sheet(isPresented: $showModalView, content: {
                    NavigationView{
                        if self.modalViewType ==  .map{
                            self.modalMap!
                            //                        EmptyView()
                        }else{
                            EmptyView()
                        }
                    }
                })
                .navigationBarTitle("Teller Bot", displayMode: .large)
            
        }
    }
    
    func sendMessage(content: String, predicted: Bool){
        self.messages.append(Message(stype: .human, mtype: .text, content: content))
        
        if predicted{
            if(content.lowercased().contains("atm")){
                let centrePoint = MKPointAnnotation()
                centrePoint.title = "London"
                centrePoint.subtitle = "Home to the 2012 Summer Olympics."
                centrePoint.coordinate = CLLocationCoordinate2D(latitude: 55.9444, longitude: 3.1870)
                
                let params: Parameters = ["lat": 55.9259422, "long": -3.1778105]
                
                AF.request("https://e05e8255.eu.ngrok.io", method: .post, parameters: params, encoding: JSONEncoding.default).response { response in
                    print(response.result)
                    switch response.result {
                    case .success(let value):
                        if let json = JSON(rawValue: value){
                            let atms = json["data"].arrayValue
                            var locations = [MKPointAnnotation]()
                            for atm in atms {
                                let annotation = MKPointAnnotation()
                                annotation.title = "ATM"
                                
                                var lat = Double(atm["Location"]["PostalAddress"]["GeoLocation"]["GeographicCoordinates"]["Latitude"].stringValue)
                                var long = Double(atm["Location"]["PostalAddress"]["GeoLocation"]["GeographicCoordinates"]["Longitude"].stringValue)
                                annotation.coordinate = CLLocationCoordinate2D(latitude: lat! , longitude: long!)
                                locations.append(annotation)
                            }
                            
                            print(locations)
                            
                            self.modalMap =  MapView(centerCoordinate: centrePoint.coordinate, annotations: locations)
                            self.showModalView.toggle()
                        }
                        
                    case.failure(let error):
                        print(error.localizedDescription)
                    }
                }
                
            }
        }
    }
    
}



extension Conversation{
    enum ModalType{
        case map
    }
}
