import Fluent

struct CreateMessages: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema(tableName)
            .id()
            .field(MessageDB.textKey, .string, .required)
            .field(MessageDB.timestampKey, .double, .required)
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema(tableName).delete()
    }
}

private let tableName = "messages"
