//
//  UserRow.swift
//  showing-users-test
//
//  Created by Iiro Alhonen on 21.07.21.
//

import SwiftUI

/// A row representing a single user.
struct UserRow: View {
    let user: User
    @Binding var userList: [User]
    @State private var isFavorite: Bool = false
    
    var body: some View {
        HStack {
            AsyncImage<Image>(
                url: URL(string: user.avatar)!,
                placeholder: Image(systemName: "person")
            ).frame(width: 50, height: 50, alignment: .leading)
            VStack(alignment: .leading) {
                Text("\(user.first_name) \(user.last_name)")
                    .font(.headline)
                Text(user.email)
                    .font(.footnote)
            }
            Spacer()
            Button(action: {
                isFavorite.toggle()
                if let index = userList.firstIndex(where: { user in
                    user.id == self.user.id
                }) {
                    userList[index].isFavorite = isFavorite
                }
            }, label: {
                Image(systemName: isFavorite ? "star.fill" :"star")
            })
        }.onAppear(perform: {
            isFavorite = user.isFavorite
        })
    }
}
