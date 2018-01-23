import Vapor

extension Droplet {
    func setupRoutes() throws {
        get("hello") { req in
            var json = JSON()
            try json.set("hello", "world")
            return json
        }

        get("plaintext") { req in
            return "Hello, world!"
        }

        // response to requests to /info domain
        // with a description of the request
        get("info") { req in
            return req.description
        }

        get("description") { req in return req.description }
        
        get("abc") { req in
            return "abc"
        }
        
        get("index") { request in
            return try self.view.make("index.html")
        }
        
    }
    
    
    
    
}

final class Routes: RouteCollection {
    
    func build(_ builder: RouteBuilder) throws {
        print("abc")
    }
    
    
}
