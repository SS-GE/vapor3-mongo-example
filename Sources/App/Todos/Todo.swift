import Vapor

public struct Todo: Content {
    public let id: String?
    public let title: String

    init(from entity: TodoEntity) {
        self.id = entity.id?.hexString
        self.title = entity.title
    }
}
