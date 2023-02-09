//
//  ChatManager.swift
//  Chat app
//
//  Created by Rustem Manafov on 07.02.23.
//

import Foundation
import StreamChat
import StreamChatUI

final class ChatManager {
    static let shared = ChatManager()
    
    private var client: ChatClient!
    
    private let tokens = [
        "rustam" : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoicnVzdGFtIn0.tHgGYgKPFsQYuAB59c7cPI1RxErNZIJIW4g7j_JfH-Y",
        "stevejobs" : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoic3RldmVqb2JzIn0.5XF55YhwLOuxQ89N_IVBZaHgAUlpdX7uWfJxx2yC7tY"]
    
    func setup() {
        let client = ChatClient(config: .init(apiKey: .init("4652rvusfd2b")))
        self.client = client
    }
    
    
    func signIn(with username: String, completion: @escaping (Bool)-> Void) {
        guard !username.isEmpty else {
            completion(false)
            return
        }
        
        guard let token = tokens[username.lowercased()] else {
            completion(false)
            return
        }
        
        client.connectUser(userInfo: UserInfo(id: username, name: username), token: Token(stringLiteral: token)) { error in
            completion(error == nil)
        }
    }
    
    func signOut() {
        client.disconnect()
        client.logout()
        }
    
    var isSignedIn: Bool {
        return client.currentUserId != nil
    }
    
    var currentUser: String? {
        return client.currentUserId
    }
    
    public func createChannelList() -> UIViewController? {
        guard let id = currentUser else {return nil}
        let list = client.channelListController(query: .init(filter: .containMembers(userIds: [id])))
        let vc = ChatChannelListVC()
        vc.content = list
        list.synchronize()
        return vc
    }
    
    public func createNewChannel(name: String) {
        guard let current = currentUser else {return}
        let keys: [String] = tokens.keys.filter({ $0 != current }).map{$0}
        do {
            let result = try client.channelController(createChannelWithId: .init(type: .messaging, id: name),
                                                      name: name,
                                                      members: Set(keys),
                                                      isCurrentUserMember: true)
            result.synchronize()
        } catch {
            print("\(error)")
        }
    }
}
