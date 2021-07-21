//
//  UserListView.swift
//  showing-users-test
//
//  Created by Iiro Alhonen on 21.07.21.
//

import SwiftUI

/// The view for listing users.
struct UserListView: View {
    @Binding var userList: [User]
    let title: String
    
    var body: some View {
        NavigationView {
            if userList.isEmpty {
                Text("No users found.")
                    .navigationBarTitle(title)
            } else {
                List {
                    if title == "Favorites" {
                        let filteredList = userList.filter { user in
                            user.isFavorite
                        }
                        ForEach(filteredList, id: \.id) { user in
                            UserRow(user: user, userList: $userList)
                        }
                    } else {
                        ForEach(userList, id: \.id) { user in
                            UserRow(user: user, userList: $userList)
                        }
                    }
                }
                .navigationBarTitle(title)
            }
        }
    }
}
