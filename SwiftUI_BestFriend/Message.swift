//
//  Message.swift
//  SwiftUI_BLE
//
//  Created by digital on 08/11/2023.
//

import Foundation
import UIKit

struct Message:ModelProtocol{
    var id = UUID().uuidString
    var userName: String
    var text: String?
    var image: UIImage? // Ajouter une propriété pour l'image

    static func defaultMessage() -> Message {
        // Retourner un exemple de Message
        return Message(userName: "Jojo", text: "Hello!", image: nil)
    }
}


enum DataType:UInt8{
    case Text=0x01
    case Image=0x02
}
