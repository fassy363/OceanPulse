
import Foundation
import SwiftUI
import RealmSwift

enum Category: String, CaseIterable, PersistableEnum {
    case easy = "Easy"
    case medium = "Medium"
    case hard = "Hard"
}

final class MainViewModel: ObservableObject {
    @Published var items: [ItemViewModel]
    @Published var category: Category {
        didSet {
            UserDefaults.standard.string(forKey: "category")
        }
    }

    init(items: [ItemViewModel], category: Category) {
        self.items = items
        self.category = category
    }
    
    func easyLoadData() {
        let storage: ModelStorage = .init()
        
        let levelItems: [ItemViewModel] = storage.read().first?.easyExers
            .compactMap { makeEasyCell(for: $0) } ?? []
        
        items = levelItems
    }
    
    func makeEasyCell(
        for model: EasyDomainModel
    ) -> ItemViewModel? {
        return .init(id: model.id.uuidString, image: model.image, title: model.title, description: model.descriptions)
    }
    
    func mediumLoadData() {
        let storage: ModelStorage = .init()
        
        let levelItems: [ItemViewModel] = storage.read().first?.mediumExers
            .compactMap { makeMediumCell(for: $0) } ?? []
        
        items = levelItems
    }
    
    func makeMediumCell(
        for model: MediumDomainModel
    ) -> ItemViewModel? {
        return .init(id: model.id.uuidString, image: model.image, title: model.title, description: model.descriptions)
    }
    
    func hardLoadData() {
        let storage: ModelStorage = .init()
        
        let levelItems: [ItemViewModel] = storage.read().first?.hardExers
            .compactMap { makeHardCell(for: $0) } ?? []
        
        items = levelItems
    }
    
    func makeHardCell(
        for model: HardDomainModel
    ) -> ItemViewModel? {
        return .init(id: model.id.uuidString, image: model.image, title: model.title, description: model.descriptions)
    }
}
