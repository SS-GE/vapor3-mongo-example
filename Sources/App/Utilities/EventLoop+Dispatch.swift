import NIO
import Dispatch

extension EventLoop {
    func dispatch<T>(to queue: DispatchQueue = DispatchQueue.global(),
                     _ work: @escaping () throws -> T) -> EventLoopFuture<T> {
        let promise = self.newPromise(T.self)

        queue.async {
            do {
                let result = try work()
                promise.succeed(result: result)
            } catch {
                promise.fail(error: error)
            }
        }

        return promise.futureResult
    }
}
