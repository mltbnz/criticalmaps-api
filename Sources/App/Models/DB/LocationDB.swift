import Fluent
import Vapor

final class LocationDB: Model, Content {
  static let schema = "locations"
  
  @ID(key: .id)
  var id: UUID?
  @Field(key: LocationDB.latitudeKey)
  var latitude: Double
  @Field(key: LocationDB.longitudeKey)
  var longitude: Double
  @Field(key: LocationDB.timestampKey)
  var timestamp: Double
  
  init() { }
  
  init(device: String?, location: Location) {
    self.id = device.flatMap { UUID(uuidString: $0) } ?? UUID()
    self.timestamp = location.timestamp
    self.latitude = location.coordinate.latitude
    self.longitude = location.coordinate.longitude
  }
}

extension LocationDB {
  static let latitudeKey: FieldKey = "latitude"
  static let longitudeKey: FieldKey = "longitude"
  static let timestampKey: FieldKey = "timestamp"
}
