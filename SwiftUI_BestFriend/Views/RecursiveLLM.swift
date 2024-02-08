//
//  RecursiveLLM.swift
//  SwiftUI_Merveille
//
//  Created by digital on 20/11/2023.
//

import SwiftUI

struct RecursiveLLM: View {
    
    var preprompt = ""
    @State var startPrompt:String = "Voici une liste de phrases, catégorise les en \"positif\" ou \"négatif\": ['Salut l'ami!', 'Ce film me saoule', 'J'adore swiftui', 'La prairie est belle']. Ta réponse sera sous la forme d'une liste de 1 et de 0 pour positif ou négatif tel que [0, 1, ...]."
    
    @ObservedObject var model = ChatObservable()
    
    @State var selectedPrompt = 0
    
    var prompts:[String] = [
        "Explique moi ce qui pose problème à l'utilisateur dans la phrase suivante : #PROMPT#",
        "Demande à l'utilisateur pourquoi #PROMPT#",
    ]
    
    var contextPrompts:[String] = [
    ]
    
    var body: some View {
        VStack{
            TextField("Prompt de départ", text: $startPrompt)
                .onSubmit {
                    var prompt = prompts[selectedPrompt].replacingOccurrences(of: "#PROMPT#", with: startPrompt)
                    model.sendChat(message: prompt, image: UIImage())
                    self.selectedPrompt += 1
                }
            ForEach(prompts, id:\.self){ prompt in
                Text(prompt).fontWeight(prompts.index(of: prompt) == self.selectedPrompt-1 ? .bold : .medium)
                Rectangle().frame(height: 1)
            }
            Spacer()
            ForEach(model.messageList){response in
                Text(response.text!)
                Rectangle().frame(height: 1)
            }
        }.onChange(of: model.messageList, perform: { value in
            if let lastMessage = value.last,
               let receveivedText = lastMessage.text{
                if(self.selectedPrompt < self.prompts.count){
                    var prompt = prompts[selectedPrompt].replacingOccurrences(of: "#PROMPT#", with: receveivedText)
                    model.sendChat(message: prompt, image: UIImage())
                    self.selectedPrompt += 1
                }
            }
        })
    }
}

#Preview {
    RecursiveLLM()
}
