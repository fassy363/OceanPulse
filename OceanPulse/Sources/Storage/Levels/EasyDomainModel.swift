
import Foundation
import RealmSwift

final class EasyDomainModel: Object {
    @Persisted(primaryKey: true)  var id: UUID = .init()
    @Persisted var image: String = ""
    @Persisted var title: String = ""
    @Persisted var descriptions: String = ""
        
    convenience init(
        id: UUID = .init(),
        image: String,
        title: String,
        descriptions: String
    ) {
        self.init()
        self.id = id
        self.image = image
        self.title = title
        self.descriptions = descriptions
    }
}
