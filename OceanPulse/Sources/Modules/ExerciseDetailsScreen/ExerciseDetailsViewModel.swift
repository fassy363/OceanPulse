
import Foundation

final class ExerciseDetailsViewModel: ObservableObject, Hashable {
    @Published var id: String
    @Published var title: String
    @Published var image: String
    @Published var description: String
    
    init(id: String, title: String, image: String, description: String) {
        self.id = id
        self.title = title
        self.image = image
        self.description = description
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: ExerciseDetailsViewModel, rhs: ExerciseDetailsViewModel) -> Bool {
        return lhs.id == rhs.id &&
            lhs.title == rhs.title &&
            lhs.image == rhs.image &&
            lhs.description == rhs.description
    }
}
