import Vapor

struct LocationAndMessagesInput: Content {
  var device: String?
  var location: Location?
  var message: ChatMessagePost?
}
