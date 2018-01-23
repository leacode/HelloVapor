//
//  QoutesController.swift
//  App
//
//  Created by leacode on 2018/1/23.
//

import Vapor
import FluentProvider

struct QuotesController {
    
    func addRoutes(to drop: Droplet) {
        let quots = drop.grouped("api","quots")
        //添加一个新的quots
        quots.post("create", handler: createQuots)
        //查询所有的quotes
        quots.get(handler: allQuotes)
        // 更新quotes
        quots.post("update", handler: updateQuotes)
        // 删除quotes
        quots.post("delete", handler: deleteQuotes)

    }

    /// 添加一个新的quots
    func createQuots(_ req: Request) throws -> ResponseRepresentable {
        guard let json = req.json else {
            throw Abort.badRequest
        }
        let quots = try Quotes(json: json)
        try quots.save()
        return quots
    }
    
    /// 查询所有的quots
    func allQuotes(_ req: Request) throws -> ResponseRepresentable {
        let quots = try Quotes.all()
        return try quots.makeJSON()
    }
    /// 更新quotes
    func updateQuotes(_ req: Request) throws -> ResponseRepresentable {
        guard let json = req.json else {
            throw Abort.badRequest
        }
        
        let id: Int = try json.get("id")
        if let quots = try Quotes.find(id) {
            try quots.update(json: json)
        }
        
        return try Quotes.all().makeJSON()
    }
    
    // 删除quotes
    func deleteQuotes(_ req: Request) throws -> ResponseRepresentable {
        guard let json = req.json else {
            throw Abort.badRequest
        }
        let id: Int = try json.get("id")
        if let quots = try Quotes.find(id) {
            try quots.delete()
        }
        
        return try Quotes.all().makeJSON()
    }
    
}
