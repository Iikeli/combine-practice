//
//  UserLoader.swift
//  showing-users-test
//
//  Created by Iiro Alhonen on 21.07.21.
//
import SwiftUI
import Combine
import Foundation

/// The class used to load users from the API.
class UserLoader: ObservableObject {
    @Published var userList: [User] = []
    private let url: URL = URL(string: "https://reqres.in/api/users")!
    private var cancellable: AnyCancellable?
    private let decoder = JSONDecoder()
    
    deinit {
        cancel()
    }
    
    private func fetchData() -> AnyPublisher<Data, URLError> {
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .eraseToAnyPublisher()
    }
    
    func load() {
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: Initial.self, decoder: decoder)
            .map { $0.data }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { complete in
                print("Finished: \(complete)")
            }, receiveValue: { user in
                self.userList = user
                print(user)
            })
    }
    
    func cancel() {
        cancellable?.cancel()
    }
}
