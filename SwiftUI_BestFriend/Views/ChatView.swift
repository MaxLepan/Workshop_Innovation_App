//
//  ContentView.swift
//  SwiftUI_BestFriend
//
//  Created by digital on 10/11/2023.
//

import SwiftUI
import UIKit

struct ChatView: View {
    @ObservedObject private var chatObservable = ChatObservable()
    @State var message = ""
    @State var showSettings = false
    @State var showImagePicker = false
    @State var showPopup = false
    @State var showConfidentialityPage = false
    @State var image:UIImage = UIImage()
    
    var body: some View {
        GeometryReader { geometry in
            VStack{
                VStack {
                    HStack {
                        Spacer()
                        Image("gear")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 30, height: 10)
                            .padding()
                            .onTapGesture {
                                self.showSettings = true
                            }
                    }.padding(.top, 45)
                    
                    List(self.$chatObservable.messageList){message in
                        MessageView(message: message.wrappedValue)
                    }
                    .listStyle(PlainListStyle())
                    .background(.clear)
                    .padding()
                    
                    if image.size.width > 0 {
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 100)
                            .onTapGesture {
                                self.image = UIImage()
                            }
                    }
                }.background(
                    Image("fond-degrade")
                        .resizable()
                        .frame(width: geometry.size.width, height: geometry.size.height-40)
                        
                )
                HStack{
                    Image("scanner")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 40, height: 40)
                        .padding()
                        .onTapGesture {
                            self.showImagePicker = true
                        }
                    TextField("Message to send…", text: $message)
                        .background(RoundedRectangle(cornerRadius: 50).fill(Color(red: 200 / 255, green: 186 / 255, blue: 211 / 255)))
                        .overlay(
                            RoundedRectangle(cornerRadius: 50).fill(.clear)
                        )
                        .onSubmit {
                            self.chatObservable.sendChat(message: message, image: image)
                            self.message = ""
                            self.image = UIImage()
                        }
                    Image("microphone")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 40, height: 40)
                        .padding()
                }.padding()
            }.sheet(isPresented: $showSettings, content: {
                SettingsView()
            })
            .sheet(isPresented: $showImagePicker, content: {
                ImagePicker(selectedImage: $image)
            })
            .sheet(isPresented: $showConfidentialityPage, content: {
                ConfidentialityView(showPage: self.$showConfidentialityPage)
            })
            .onAppear {
                showPopup = true
            }
            .alert("Politique de confidentialité", isPresented: $showPopup){
                Button("Voir la politique de confidentialité") {
                    showConfidentialityPage = true
                }
                Button("Accepter"){}
                Button("Refuser", role: .cancel){}
            } message: {
                Text("En cliquant sur \"Accepter\", vous agréez à notre politique de confidentialité")
            }
        }.ignoresSafeArea()
    }
}

#Preview {
    ChatView()
}
