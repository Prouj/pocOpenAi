//
//  ChatViewModel.swift
//  HackathonExpolog
//
//  Created by Matheus Meneses on 21/11/24.
//
//
import Foundation
import OpenAI

//class ChatController: ObservableObject {
//    @Published var messages: [Message] = []
//    
//    let openAI = OpenAI(apiToken: "key")
//    
//    func sendNewMessage(content: String) {
//        let userMessage = Message(content: content, isUser: true)
//        self.messages.append(userMessage)
//        getBotReply()
//    }
//    
//    func getBotReply() {
//        let query = ChatQuery(
//            messages: self.messages.map({
//                .init(role: .user, content: $0.content)!
//            }),
//            model: .gpt3_5Turbo
//        )
//        
//        openAI.chats(query: query) { result in
//            switch result {
//            case .success(let success):
//                guard let choice = success.choices.first else {
//                    return
//                }
//                guard let message = choice.message.content?.string else { return }
//                DispatchQueue.main.async {
//                    self.messages.append(Message(content: message, isUser: false))
//                }
//            case .failure(let failure):
//                print(failure)
//            }
//        }
//    }
//}
