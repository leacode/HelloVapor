//
//  CommandTest.swift
//  App
//
//  Created by leacode on 2018/1/20.
//

import Vapor
import Console

public final class MyCustomCommand: Command {
    public let id = "my-command"
    public let help = ["This command does things, like foo, and bar."]
    public let console: ConsoleProtocol
    
    public init(console: ConsoleProtocol) {
        self.console = console
    }
    
    public func run(arguments: [String]) throws {
        console.print("running custom command...")
    }
}

extension MyCustomCommand: ConfigInitializable {
    public convenience init(config: Config) throws {
        let console = try config.resolveConsole()
        self.init(console: console)
    }
}
