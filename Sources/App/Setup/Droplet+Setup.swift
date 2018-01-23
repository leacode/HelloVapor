@_exported import Vapor

extension Droplet {
    public func setup() throws {
        try setupRoutes()
        try setupTestRoutes()
        try setupGroupRoutes()
        setupQuotes()
        
        try collection(TestCollection.self)
    }
}
