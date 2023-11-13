import Vapor

struct CommentController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let comments = routes.grouped("comments")
        comments.post(use: create)
        comments.get(use: getAll)
        comments.group(":commentID") { comment in
            comment.delete(use: delete)
        }
    }

    func create(req: Request) async throws -> Comment {
        let comment = try req.content.decode(Comment.self)
        try await comment.save(on: req.db)
        return comment
    }

    func getAll(req: Request) async throws -> [Comment] {
        try await Comment.query(on: req.db).all()
    }

    func delete(req: Request) async throws -> HTTPStatus {
        guard let comment = try await Comment.find(req.parameters.get("commentID"), on: req.db) else {
            throw Abort(.notFound)
        }
        try await comment.delete(on: req.db)
        return .ok
    }
}
