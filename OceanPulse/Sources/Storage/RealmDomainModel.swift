
import Foundation
import RealmSwift

final class RealmDomainModel: Object {
    @Persisted(primaryKey: true)  var id: UUID = .init()
    @Persisted var easyExers: List<EasyDomainModel>
    @Persisted var mediumExers: List<MediumDomainModel>
    @Persisted var hardExers: List<HardDomainModel>
        
    convenience init(
        id: UUID = .init(),
        easyExers: List<EasyDomainModel>,
        mediumExers: List<MediumDomainModel>,
        hardExers: List<HardDomainModel>
    ) {
        self.init()
        self.id = id
        self.easyExers = easyExers
        self.mediumExers = mediumExers
        self.hardExers = hardExers
    }
}
