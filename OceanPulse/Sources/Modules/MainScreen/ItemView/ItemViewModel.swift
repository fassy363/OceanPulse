
import Foundation

final class ItemViewModel: ObservableObject, Hashable {
    @Published var id: String
    @Published var image: String
    @Published var title: String
    @Published var description: String
    
    init(id: String, image: String, title: String, description: String) {
        self.id = id
        self.image = image
        self.title = title
        self.description = description
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: ItemViewModel, rhs: ItemViewModel) -> Bool {
        return lhs.id == rhs.id &&
            lhs.image == rhs.image &&
            lhs.title == rhs.title &&
            lhs.description == rhs.description
    }
}
