//
//  ViewModel.swift
//  Import to notion
//
//  Created by Роман далинкевич on 05.08.2021.
//

import Foundation
import Combine


enum NotionAPIError: Error, Identifiable {
    case serverError
    case noData
    
    var id: Self {
        self
    }
}

class ViewModel: ObservableObject {
    
    @Published var users: [NotionDatabaseRowUserObject] = []
    @Published var database: NotionDatabase?
    
    
    private var cancellable: AnyCancellable?
    private let urlSession = URLSession(configuration: .default)
    private let baseURL = "https://api.notion.com/v1/databases"
    private let databaseId = "147e77e5d74f4f80bb1fada475700845" // The database ID
    private let accessToken = "secret_o1nu5OO60FXms25f9GKgiKshBBGHvZt00AdfDB44uPU" // token
}

extension ViewModel {
    // query database rows
    // https://developers.notion.com/reference/post-database-query
    
    func queryFromDatabase() {
        
        let urlString = baseURL + "/" + databaseId + "/query"
        guard let apiURL = URL(string: urlString) else { return }
        var apiURLRequest = URLRequest(url: apiURL)
        
        apiURLRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        apiURLRequest.addValue("2021-05-13", forHTTPHeaderField: "Notion-Version")
        apiURLRequest.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        apiURLRequest.httpMethod = "POST"
        
        apiURLRequest.httpBody = """
            {
                "sorts": [
                    {
                        "property": "Name",
                        "direction": "ascending"
                    }
                ]
            }
            """.data(using: .utf8)
        
        cancellable = urlSession
            .dataTaskPublisher(for: apiURLRequest)
            .tryMap { output in
                guard let response = output.response as? HTTPURLResponse, response.statusCode == 200 else {
                    throw NotionAPIError.serverError
                }
                return output.data
            }
            .decode(type: NotionDatabaseQueryResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { (subscriber) in

                    switch subscriber {
                    case .failure(let error):
                        print("Error: \(error.localizedDescription)")
                    case .finished:
                        break
                    }

                },
                receiveValue: { [weak self] database in
                    guard let self = self else { return }
                    self.users = database.results
                }
            )
    }

}
