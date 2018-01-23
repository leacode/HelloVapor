//
//  Quotes.swift
//  App
//
//  Created by leacode on 2018/1/23.
//

import Vapor
import FluentProvider
import HTTP

/// 名人名言
final class Quotes: Model {
    
    // 这个属性能让Fluent存储额外的信息，如这个model的id
    let storage = Storage()
    
    //***下面是表中的属性***
    
    /// 作者
    var author: String
    /// 内容
    var content: String
    /// 描述
    var description: String
    
    /// 数据库中列的名字
    struct Keys {
        static let id = "id"
        static let author = "author"
        static let content = "content"
        static let description = "description"
    }
    
    // MARK: 初始化Fluent
    init(author: String, content: String, description: String) {
        self.author = author
        self.content = content
        self.description = description
    }
    
    /// 初始化Quotes
    required init(row: Row) throws {
        author = try row.get(Quotes.Keys.author)
        content = try row.get(Quotes.Keys.content)
        description = try row.get(Quotes.Keys.description)
    }
    
    // 序列化Quotes到数据库
    func makeRow() throws -> Row {
        var row = Row()
        try row.set(Quotes.Keys.author, author)
        try row.set(Quotes.Keys.content, content)
        try row.set(Quotes.Keys.description, description)
        return row
    }

}

extension Quotes: Preparation {
    
    static func prepare(_ database: Database) throws {
        try database.create(self) { quotes in
            quotes.id()
            quotes.string("author")
            quotes.string("content")
            quotes.string("description")
        }
    }
    
    static func revert(_ database: Database) throws {
        try database.delete(self)
    }
    
}

extension Quotes: JSONConvertible {
    convenience init(json: JSON) throws {
        self.init(
            author: try json.get(Quotes.Keys.author),
            content: try json.get(Quotes.Keys.content),
            description: try json.get(Quotes.Keys.description)
        )
    }
    
    func makeJSON() throws -> JSON {
        var json = JSON()
        try json.set(Quotes.Keys.id, id)
        try json.set(Quotes.Keys.author, author)
        try json.set(Quotes.Keys.content, content)
        try json.set(Quotes.Keys.description, description)
        return json
    }
}

extension Quotes {
    
    func update(json: JSON) throws {
        self.author = try json.get(Quotes.Keys.author)
        self.content = try json.get(Quotes.Keys.content)
        self.description = try json.get(Quotes.Keys.description)
        try self.save()
    }
    
}

extension Quotes: ResponseRepresentable {
    
}

extension Quotes: Parameterizable {
    
    
    
}

