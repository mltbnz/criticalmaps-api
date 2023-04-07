import Foundation
import Fluent
import Vapor

func routes(_ app: Application) throws {
  app.get("social") { req async -> String in
    "Hello, world!"
  }
  
  try app.register(collection: LocationAndMessagesController())
}
