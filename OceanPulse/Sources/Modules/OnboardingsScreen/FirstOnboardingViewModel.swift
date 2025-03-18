
import Foundation
import RealmSwift

final class FirstOnboardingViewModel: ObservableObject {
    func loadData() {
        let storage: ModelStorage = .init()
        
        guard storage.read().isEmpty else { return }
        
        let easy = List<EasyDomainModel>()
        let medium = List<MediumDomainModel>()
        let hard = List<HardDomainModel>()
        
        easy.append(.init(image: "easyLvl1", title: "One-Leg Balance", descriptions: "Stand on one leg, bend the other knee. Hold your balance for 30–60 seconds. To increase difficulty, close your eyes or use a balance board."))
        easy.append(.init(image: "easyLvl2", title: "Pop-up Drill", descriptions: "Lie on your stomach, hands near your chest. Push up your chest, then quickly pull your legs under your body into a surfing stance. Repeat 10–15 times."))
        easy.append(.init(image: "easyLvl3", title: "Plank", descriptions: "Hold a plank position on your elbows or palms for 30–60 seconds, keeping your body straight."))
        easy.append(.init(image: "easyLvl4", title: "Bridge Pose", descriptions: "Lie on your back, bend your knees, and place your feet on the floor. Lift your hips, engaging your core and glutes. Hold for 20 seconds, repeat 5 times."))
        easy.append(.init(image: "easyLvl5", title: "Superman Exercise", descriptions: "Lie on your stomach, lift your arms and legs simultaneously, mimicking a swimming motion. Hold for 30 seconds, then rest."))
        easy.append(.init(image: "easyLvl6", title: "Balance Board Training", descriptions: "Stand on a balance board or roller and try to maintain balance for 30–60 seconds."))
        easy.append(.init(image: "easyLvl7", title: "Hamstring Stretch", descriptions: "Stand upright, bend forward, and try to touch your toes. Hold for 20 seconds."))
        easy.append(.init(image: "easyLvl8", title: "Push-ups", descriptions: "Perform 10–20 push-ups, keeping your back straight."))
        
        medium.append(.init(image: "mediumLvl1", title: "Paddling", descriptions: "Lie on a balance board and mimic paddling with your arms for 30 seconds on each side."))
        medium.append(.init(image: "mediumLvl2", title: "Surf Stance Bouncing", descriptions: "Get into a surfing stance, slightly bend and straighten your legs while maintaining balance."))
        medium.append(.init(image: "mediumLvl3", title: "Side Plank", descriptions: "Hold a side plank for 30 seconds on each side."))
        medium.append(.init(image: "mediumLvl4", title: "Hurdle Jumps", descriptions: "Jump sideways over an obstacle 15 times."))
        medium.append(.init(image: "mediumLvl5", title: "Burpees", descriptions: "Perform a burpee, but instead of jumping straight up, land in a surf stance."))
        medium.append(.init(image: "mediumLvl6", title: "Lunges with Rotation", descriptions: "Perform forward lunges while twisting your torso toward the front leg."))
        medium.append(.init(image: "mediumLvl7", title: "Jumping", descriptions: "Jump from the floor onto a balance board, trying to land in a stable stance."))
        medium.append(.init(image: "mediumLvl8", title: "Wave Simulation", descriptions: "Move your body as if you’re surfing (leaning, turning)."))
        
        hard.append(.init(image: "hardLvl1", title: "Weighted Paddling", descriptions: "Lie on a balance board and paddle using light dumbbells."))
        hard.append(.init(image: "hardLvl2", title: "Pop-up", descriptions: "Perform pop-ups on a BOSU ball for extra instability."))
        hard.append(.init(image: "hardLvl3", title: "Jumping Lunges", descriptions: "Perform lunges, switching legs mid-air."))
        hard.append(.init(image: "hardLvl4", title: "Plank with Knee Tucks", descriptions: "In a plank position, bring one knee toward your chest, then switch legs."))
        hard.append(.init(image: "hardLvl5", title: "Side-to-Side Jumps", descriptions: "Jump left and right as if moving along a surfboard."))
        hard.append(.init(image: "hardLvl6", title: "Running into Water", descriptions: "Run in shallow water while lifting and throwing the surfboard forward."))
        hard.append(.init(image: "hardLvl7", title: "Balancing", descriptions: "Lie on the surfboard in calm water and try to maintain balance."))
        hard.append(.init(image: "hardLvl8", title: "Board Dismount", descriptions: "Practice controlled dismounts from the board into the water."))
        
        storage.store(item: .init(easyExers: easy, mediumExers: medium, hardExers: hard))
    }
}
