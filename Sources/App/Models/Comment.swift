import Fluent
import Vapor

final class Comment: Model, Content {
    static let schema = "comments"

    @ID(key: .id)
    var id: UUID?

    @Field(key: "restaurantID")
    var restaurantID: Int

    @Field(key: "content")
    var content: String

    @Field(key: "score")
    var score: Int

    @Field(key: "time")
    var time: Date

    init() { }

    init(id: UUID? = nil, restaurantID: Int, content: String, score: Int, time: Date) {
        self.id = id
        self.restaurantID = restaurantID
        self.content = content
        self.score = score
        self.time = time
    }
}
