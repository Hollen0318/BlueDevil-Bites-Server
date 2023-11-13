import Fluent

struct CreateComment: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema("comments")
            .id()
            .field("restaurantID", .int, .required)
            .field("content", .string, .required)
            .field("score", .int, .required)
            .field("time", .datetime, .required)
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("comments").delete()
    }
}
