import Fluent

struct CreateLocations: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema(tableName)
            .id()
            .field(LocationDB.latitudeKey, .double, .required)
            .field(LocationDB.longitudeKey, .double, .required)
            .field(LocationDB.timestampKey, .double, .required)
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema(tableName).delete()
    }
}

private let tableName = "locations"
