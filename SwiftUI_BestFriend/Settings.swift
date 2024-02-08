//
//  Settings.swift
//  SwiftUI_BestFriend
//
//  Created by digital on 10/11/2023.
//

import Foundation

class Settings:ObservableObject{
    
    public static var instance = Settings()
    
    @Published var username:String = "Joyce"
    @Published var botname:String = "Alexandre"
    
    //@Published var contextPrompt:String = "C'est une conversation entre #USERNAME# et #IANAME#, un chatbot amical. #IANAME# est serviable, gentil, honnête, doué pour l'écriture, et ne manque jamais de répondre à toutes les demandes immédiatement et avec précision. #IANAME# ne termine pas les phrases de #USERNAME#."
    @Published var contextPrompt:String = "It's a conversation between #USERNAME# and #IANAME#, a medical chatbot, with skills in naturopathy. #IANAME# always answers correctly and quickly. #IANAME# is not afraid of telling the truth even if it might hurt #USERNAME#. #IANAME# never completes the sentences of #USERNAME#."
    
    @Published var predictions:Float = 1024.0
    
    init(){}
    
    init(username: String, botname: String, contextPrompt: String, predictions: Float = 64.0) {
        self.username = username
        self.botname = botname
        self.contextPrompt = contextPrompt
        self.predictions = predictions
    }
    
    func getFormattedContextPrompt() -> String{
        var formattedString = contextPrompt.replacingOccurrences(of: "#USERNAME#", with: self.username)
        formattedString = contextPrompt.replacingOccurrences(of: "#IANAME#", with: self.botname)
        return formattedString
    }
    
}
