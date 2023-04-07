import Vapor

struct ChatMessagePost: Content {
  var text: String?
  var timestamp: Double?
  var identifier: String?
}
