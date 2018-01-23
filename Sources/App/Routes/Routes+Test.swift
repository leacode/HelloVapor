//
//  Routes+Test.swift
//  App
//
//  Created by leacode on 2018/1/21.
//

import Vapor

extension Droplet {
    
    func setupTestRoutes() throws {
        
        post("testPost") { req in
            return "testPost result"
        }
        
        get("testGet") { req in
            return "testGet result"
        }
        
        put("testPut") { req in
            return "testPut result"
        }
        
        patch("testPatch") { req in
            return "testPatch result"
        }
        
        delete("testDelete") { req in
            return "testDelete result"
        }
        
        options("testOptions") { req in
            return "testOptions result"
        }
        
        get("age", Int.parameter) { req in
            let age = try req.parameters.next(Int.self)
            return "Age is #\(age)"
        }
        
        get("call", ":name") { req in
            guard let name = req.parameters["name"]?.string else {
                throw Abort.badRequest
            }
            return "Calling \(name)"
        }
        

    }
    
    func setupGroupRoutes() throws {
        
        group("testGroup") { testGroup in
                        
            testGroup.post("testGroup_post") { request in
                return "testGroup testGroup_post result"
            }
            testGroup.get("testGroup_get") { request in
                return "testGroup testGroup_get result"
            }
            testGroup.put("testGroup_put") { req in
                return "testGroup testGroup_put result"
            }
            
            testGroup.patch("testGroup_patch") { req in
                return "testGroup testGroup_patch result"
            }
            
            testGroup.delete("testGroup_delete") { req in
                return "testGroup testGroup_delete result"
            }
            
            testGroup.options("testGroup_options") { req in
                return "testGroup testGroup_options result"
            }
        }
        
        let testGroup = grouped("testGroup")
        testGroup.get("extra") { request in
            return "testGroup extra result"
        }

    
    }
    
}

class TestCollection: RouteCollection, EmptyInitializable {
    
    required init() {
        
    }
    
    func build(_ builder: RouteBuilder) throws {
        let testGroup = builder.grouped("testGroup")
        testGroup.get("anotherExtra") { req in
            return "testGroup extra result"
        }
    }
}

//extension User: Parameterizable {
//
//    static var uniqueSlug: String {
//        return "user"
//    }
//
//
//    static func make(for parameter: String) throws -> User {
//
//    }
//}


