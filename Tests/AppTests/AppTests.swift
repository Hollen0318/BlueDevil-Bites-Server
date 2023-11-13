@testable import App
import XCTVapor

final class AppTests: XCTestCase {
    func testHelloWorld() async throws {
        let app = Application(.testing)
        defer { app.shutdown() }
        try await configure(app)

        try app.test(.GET, "hello", afterResponse: { res in
            XCTAssertEqual(res.status, .ok)
            XCTAssertEqual(res.body.string, "Hello, world!")
        })
    }

    var app: Application!

    override func setUpWithError() throws {
        app = Application(.testing)
        try configure(app)
    }

    override func tearDownWithError() throws {
        app.shutdown()
    }

    func testCreateComment() async throws {
        let comment = Comment(restaurantID: 1, content: "Great food!", score: 5, time: Date())
        try await app.test(.POST, "comments", beforeRequest: { req in
            try req.content.encode(comment)
        }, afterResponse: { res in
            XCTAssertEqual(res.status, .ok)
            XCTAssertNotNil(res.body.string.contains("Great food!"))
        })
    }

    func testGetAllComments() async throws {
        try await app.test(.GET, "comments", afterResponse: { res in
            XCTAssertEqual(res.status, .ok)
            // Check if the response contains expected data
        })
    }

    func testDeleteComment() async throws {
        // First, create a comment
        // Then, test deletion of that comment
    }
    
}
