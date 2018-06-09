import Vapor
import MongoKitten

/// Controls basic CRUD operations on `Todo`s.
final class TodoController {
    /// Returns a list of all `Todo`s.
    func index(_ req: Request) throws -> Future<[Todo]> {
        let repo = try req.make(TodoRepository.self)

        return repo.findAll(on: req.eventLoop)
            .map { $0.map(Todo.init) }
    }

    /// Returns a single `Todo` for a given ID.
    func find(_ req: Request) throws -> Future<Todo> {
        let repo = try req.make(TodoRepository.self)
        let id = try req.parameters.next(String.self)

        guard let oid = id.objectId else {
            throw Abort(.badRequest)
        }

        return repo.findOneById(oid, on: req.eventLoop)
            .map {
                guard let entity = $0 else {
                    throw Abort(.notFound)
                }

                return Todo(from: entity)
            }
    }

    /// Saves a decoded `Todo` to the database.
    func create(_ req: Request) throws -> Future<Todo> {
        let repo = try req.make(TodoRepository.self)

        return try req.content.decode(Todo.self).flatMap { todo -> Future<TodoEntity> in
            let entity = TodoEntity(id: todo.id?.objectId, title: todo.title)
            return repo.save(entity, on: req.eventLoop)
        }.map(Todo.init)
    }

    /// Deletes a parameterized `Todo`.
    func delete(_ req: Request) throws -> Future<HTTPStatus> {
        let repo = try req.make(TodoRepository.self)
        let id = try req.parameters.next(String.self)

        guard let oid = id.objectId else {
            throw Abort(.badRequest)
        }

        return repo.deleteById(oid, on: req.eventLoop)
            .transform(to: .ok)
    }
}
