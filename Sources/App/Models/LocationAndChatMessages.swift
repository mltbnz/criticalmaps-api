import Vapor

struct LocationAndChatMessages: Content {
  let locations: [LocationResponse]
  let chatMessages: [MessageResponse]
}

struct LocationResponse {
  let id: String
  let location: Location
}

extension LocationResponse: Content {}
extension LocationResponse {
  init?(dbLocation: LocationDB) {
    guard
      let id = dbLocation.id?.uuidString
    else {
      return nil
    }
    
    self.id = id
    self.location = Location(
      coordinate: .init(
        latitude: dbLocation.latitude,
        longitude: dbLocation.latitude
      ),
      timestamp: dbLocation.timestamp
    )
  }
}

struct MessageResponse {
  let id: String
  let text: String
  let timestamp: Double
}

extension MessageResponse: Content {}
extension MessageResponse {
  init?(dbMessage: MessageDB) {
    guard
      let id = dbMessage.id?.uuidString,
      let text = dbMessage.text
    else {
      return nil
    }
    
    self.id = id
    self.text = text
    self.timestamp = dbMessage.timestamp
  }
}

