import Vapor

struct ChatMessage: Content {
  var message: String
  var timestamp: Double
}
