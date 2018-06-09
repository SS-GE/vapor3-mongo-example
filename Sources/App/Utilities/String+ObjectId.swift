import MongoKitten

extension String {
    var objectId: ObjectId? {
        guard let objectId = try? ObjectId(self) else {
            return nil
        }

        return objectId
    }
}
