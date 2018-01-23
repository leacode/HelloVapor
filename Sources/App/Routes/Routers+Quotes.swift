//
//  Routers+Quotes.swift
//  App
//
//  Created by leacode on 2018/1/23.
//

import Vapor

extension Droplet {
    
    func setupQuotes() {
        let quotsController = QuotesController()
        quotsController.addRoutes(to: self)
    }
    
}
