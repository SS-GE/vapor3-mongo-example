import MongoKitten
import Vapor

protocol TodoRepository {
    func findAll(on: EventLoop) -> Future<[TodoEntity]>
    func findOneById(_ id: ObjectId, on: EventLoop) -> Future<TodoEntity?>
    func deleteById(_ id: ObjectId, on: EventLoop) -> Future<Void>
    func save(_ todo: TodoEntity, on: EventLoop) -> Future<TodoEntity>
}

final class MKTodoRepository: TodoRepository, Service {
    private let collection: MongoKitten.Collection

    init(collection: MongoKitten.Collection) {
        self.collection = collection
    }

    func findAll(on eventLoop: EventLoop) -> Future<[TodoEntity]> {
        return eventLoop.dispatch {
            let documents = try self.collection.find()
            let decoder = BSONDecoder()
            return try documents.map { try decoder.decode(TodoEntity.self, from: $0) }
        }
    }

    func findOneById(_ id: ObjectId, on eventLoop: EventLoop) -> Future<TodoEntity?> {
        return eventLoop.dispatch {
            guard let document = try self.collection.findOne("_id" == id) else {
                return nil
            }

            let decoder = BSONDecoder()
            return try decoder.decode(TodoEntity.self, from: document)
        }
    }

    func deleteById(_ id: ObjectId, on eventLoop: EventLoop) -> Future<Void> {
        return eventLoop.dispatch {
            try self.collection.remove("_id" == id,
                                       limitedTo: 1,
                                       writeConcern: nil,
                                       stoppingOnError: false)
        }
    }

    func save(_ todo: TodoEntity, on eventLoop: EventLoop) -> Future<TodoEntity> {
        return eventLoop.dispatch {
            let encoder = BSONEncoder()
            let document = try encoder.encode(todo)
            let id = try self.collection.insert(document)
            var result = todo
            result.id = id as? ObjectId
            return result
        }
    }
}
