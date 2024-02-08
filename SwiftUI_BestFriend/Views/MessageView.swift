//
//  MessageView.swift
//  SwiftUI_BestFriend
//
//  Created by digital on 10/11/2023.
//

import SwiftUI

struct MessageView: View {
    var message: Message

        var body: some View {
            HStack {
                if message.userName.elementsEqual("Jojo") {
                    Spacer()
                }
                VStack {
                    Text(message.userName)
                    if let text = message.text {
                        Text(text)
                    }
                    if let image = message.image {
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                }
            }
        }
}

#Preview {
    let message = Message.defaultMessage()
    return MessageView(message: message)
}

