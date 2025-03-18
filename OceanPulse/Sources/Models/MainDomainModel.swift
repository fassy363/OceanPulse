
import Foundation
import RealmSwift

struct MainDomainModel {
    var id: UUID
    var easyExers: List<EasyDomainModel>
    var mediumExers: List<MediumDomainModel>
    var hardExers: List<HardDomainModel>
    
    init(
        id: UUID = .init(),
        easyExers: List<EasyDomainModel>,
        mediumExers: List<MediumDomainModel>,
        hardExers: List<HardDomainModel>
    ) {
        self.id = id
        self.easyExers = easyExers
        self.mediumExers = mediumExers
        self.hardExers = hardExers
    }
}
