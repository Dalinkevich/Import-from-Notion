//
//  Data.swift
//  Import to notion
//
//  Created by Роман далинкевич on 02.08.2021.
//

import Foundation

// https://developers.notion.com/docs

struct NotionDatabase: Decodable, Identifiable { // https://developers.notion.com/reference-link/database
    let object: String
    let id: String
    let created_time: String
}

struct NotionDatabaseQueryResponse: Decodable {
    let object: String
    let results: [NotionDatabaseRowUserObject]
}

struct NotionDatabaseRowUserObject: Decodable, Identifiable {
    let id: String
    let created_time: String
    let last_edited_time: String
    let properties: UserProperties
}

struct UserProperties: Decodable {
    let Email: EmailObject
    let Name: NameObject
}

struct NameObject: Decodable {
    let title: [PlainText]
}

struct EmailObject: Decodable {
    let rich_text: [PlainText]
}

struct PlainText: Decodable {
    let plain_text: String
}
