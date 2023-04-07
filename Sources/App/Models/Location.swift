import Vapor

struct Location: Content {
  let coordinate: Coordinate
  var timestamp: Double
  var name: String?
}
