import Fluent
import Vapor

struct LocationAndMessagesController: RouteCollection {
  func boot(routes: RoutesBuilder) throws {
    let locationsAndMessages = routes.grouped("")
    locationsAndMessages.post(use: create)
  }
  
  func create(req: Request) async throws -> LocationAndChatMessages {
    try await storeLocationAndMessage(req: req)
    
    async let locations = try await getLocations(req: req)
    async let messages = try await getMessages(req: req)
    
    let response: LocationAndChatMessages = LocationAndChatMessages(
      locations: try await locations,
      chatMessages: try await messages
    )
    
    return response
  }
  
  private func getLocations(req: Request) async throws -> [LocationResponse] {
    let dbLocations = try await LocationDB.query(on: req.db).all()
    return dbLocations.compactMap { LocationResponse(dbLocation: $0) }
  }
  
  private func getMessages(req: Request) async throws -> [MessageResponse] {
    let dbMessages = try await MessageDB.query(on: req.db).all()
    return dbMessages.compactMap { MessageResponse(dbMessage: $0) }
  }
  
  private func storeLocationAndMessage(req: Request) async throws {
    do {
      let input = try req.content.decode(LocationAndMessagesInput.self)
      await withThrowingTaskGroup(of: Void.self) { group in
        // store location from input when available
        if let location = input.location {
          let locations = LocationDB(
            device: input.device,
            location: location
          )
          group.addTask {
            try await locations.save(on: req.db)
          }
        }
        
        // store messages
        if let message = input.message, let id = message.identifier, let text = message.text {
          let messageInput = MessageDB(
            id: id,
            text: text,
            timestamp: message.timestamp
          )
          group.addTask {
            try await messageInput.save(on: req.db)
          }
        }
      }
    } catch {
      throw Abort(.internalServerError)
    }
  }
}
