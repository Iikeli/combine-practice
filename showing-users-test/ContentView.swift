//
//  ContentView.swift
//  showing-users-test
//
//  Created by Iiro Alhonen on 21.07.21.
//

import SwiftUI
import Combine

/// The main view showing consisting of the tab view used to show the lists of users.
struct ContentView: View {
    @StateObject private var userLoader = UserLoader()
    @State private var userList: [User] = []
    @State private var selection = 1
    
    var body: some View {
        TabView(selection: $selection) {
            UserListView(userList: $userList, title: "Users")
                .tabItem {
                    VStack {
                        Image(
                            systemName: selection == 1
                                ? "person.3.fill"
                                : "person.3")
                        Text("Users")
                    }
                }.tag(1)
            UserListView(userList: $userList, title: "Favorites")
            .tabItem {
                VStack {
                    Image(
                        systemName: selection == 2
                            ? "star.fill"
                            : "star")
                    Text("Favorites")
                }
            }.tag(2)
        }.onAppear(perform: {
            userLoader.load()
        })
        .onReceive(userLoader.$userList, perform: { userList in
            self.userList = userList
        })
    }
}
