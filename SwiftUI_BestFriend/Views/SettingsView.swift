//
//  SettingsView.swift
//  SwiftUI_BestFriend
//
//  Created by digital on 10/11/2023.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var settings:Settings = Settings.instance
    var body: some View {
        VStack{
            HStack{
                TextField("Your name", text: $settings.username)
                TextField("Bot name", text: $settings.botname)
            }
            
            TextField("Context prompt", text: $settings.contextPrompt)
            
            HStack{
                Slider(value: $settings.predictions, in: -1...2048, step: 1)
                Text("\(Int(settings.predictions))").padding()
            }
        }.padding()
    }
}

#Preview {
    SettingsView()
}
