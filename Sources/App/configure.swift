import MongoKitten
import Vapor

/// Called before your application initializes.
public func configure(_ config: inout Config, _ env: inout Environment, _ services: inout Services) throws {
    /// Register routes to the router
    let router = EngineRouter.default()
    try routes(router)
    services.register(router, as: Router.self)

    /// Register middleware
    var middlewares = MiddlewareConfig() // Create _empty_ middleware config
    /// middlewares.use(FileMiddleware.self) // Serves files from `Public/` directory
    middlewares.use(ErrorMiddleware.self) // Catches errors and converts to HTTP response
    services.register(middlewares)

    let databaseUrl = Environment.get("MONGODB_URL") ?? "mongodb://localhost/test"
    let database = try MongoKitten.Database(databaseUrl)
    services.register(database)

    let threadPool = BlockingIOThreadPool(numberOfThreads: 4)
    threadPool.start()

    let todoRepository = MKTodoRepository(collection: database["todos"], threadPool: threadPool)
    services.register(todoRepository, as: TodoRepository.self)
}

