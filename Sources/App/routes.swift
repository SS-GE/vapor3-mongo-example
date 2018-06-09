import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    // Basic "Hello, world!" example
    router.get("hello") { req in
        return "Hello, world!"
    }

    // Example of configuring a controller
    let todoController = TodoController()
    router.get("todos", use: todoController.index)
    router.get("todos", String.parameter, use: todoController.find)
    router.post("todos", use: todoController.create)
    router.delete("todos", String.parameter, use: todoController.delete)
}
