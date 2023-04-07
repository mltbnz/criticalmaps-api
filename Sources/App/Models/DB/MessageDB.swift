import Fluent
import Vapor

final class MessageDB: Model, Content {
  static let schema = "messages"

  @ID(key: .id)
  var id: UUID?
  @Field(key: MessageDB.textKey)
  public var text: String?
  @Field(key: MessageDB.timestampKey)
  public var timestamp: Double
  
  init() { }
  
  init(id: String, text: String, timestamp: Double?) {
    self.id = UUID(uuidString: id) ?? UUID()
    self.text = text
    self.timestamp = timestamp ?? Date().timeIntervalSince1970
  }
}

extension MessageDB {
  static let textKey: FieldKey = "text"
  static let timestampKey: FieldKey = "timestamp"
}
