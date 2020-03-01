//
//  Message.swift
//  ChatBank
//
//  Created by Rishi Serumadar on 01/03/2020.
//  Copyright © 2020 NOSPACE. All rights reserved.
//

import Foundation
import SwiftUI

class Message: Identifiable {
    
    var id = UUID()
    var senderType: SenderType
    var messageContentType: MessageType
    var content: String
    var ts: Date
    
    init(stype: SenderType, mtype: MessageType, content: String) {
        self.senderType = stype
        self.messageContentType = mtype
        self.content = content
        self.ts = Date()
    }
    
}

extension Message{
    enum SenderType {
        case bot
        case human
    }
    
    enum MessageType {
        case picture
        case maps
        case text
    }
}
