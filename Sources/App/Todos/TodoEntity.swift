import Foundation
import MongoKitten

struct TodoEntity: Codable {
    var id: ObjectId?
    var title: String

    init(id: ObjectId? = nil, title: String) {
        self.id = id
        self.title = title
    }

    private enum CodingKeys: String, CodingKey {
        case id = "_id"
        case title
    }
}
