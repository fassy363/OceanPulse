
import SwiftUI

enum Routing: Hashable {
    case onb2
    case onb3
    case onb4
    case fill1
    case fill2
    case fill3
    case fill4
    case fill5
    case main
    case exerciseDetails(ItemViewModel)
    case acc
    case root
}

struct FirstOnboardingScreen: View {
    @ObservedObject private var viewModel: FirstOnboardingViewModel
    @State private var path: NavigationPath = .init()
    @StateObject private var authMain = AuthMain()
    @StateObject private var mainViewModel = MainViewModel(
        items: [],
        category: .easy
    )
    
    init(viewModel: FirstOnboardingViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Text("Learn to surf with our")
                    .foregroundStyle(Color.init(red: 156/255, green: 175/255, blue: 198/255))
                    .font(.system(size: 24, weight: .bold, design: .default))
                Text("AI Assistant")
                    .foregroundStyle(Color.init(red: 255/255, green: 71/255, blue: 61/255))
                    .font(.system(size: 56, weight: .heavy, design: .default))
                Text("We're excited to have you here. Get ready for a personalized experience and access to all the app’s features. Let’s get started!")
                    .foregroundStyle(Color.init(red: 109/255, green: 125/255, blue: 146/255))
                    .font(.system(size: 16, weight: .regular, design: .default))
                    .multilineTextAlignment(.center)
                Spacer()
                Button {
                    path.append(Routing.root)
                } label: {
                    Text("Get started")
                        .padding(.vertical, 16)
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(.white)
                        .font(.system(size: 28, weight: .medium, design: .default))
                }
                .background(.black)
                .cornerRadius(24)
                .padding(.bottom, 24)
            }
            .padding(.horizontal, 24)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Image(.firstOnboardingBackground)
                    .resizable()
                    .ignoresSafeArea()
            )
            .navigationDestination(for: Routing.self) { router in
                switch router {
                case .onb2:
                    SecondOnboardingScreen(path: $path)
                        .navigationBarBackButtonHidden(true)
                case .onb3:
                    ThirdOnboardingScreen(path: $path)
                        .navigationBarBackButtonHidden(true)
                case .onb4:
                    FourthOnboardingScreen(path: $path)
                        .navigationBarBackButtonHidden(true)
                case .fill1:
                    FillWeightScreen(path: $path)
                        .navigationBarBackButtonHidden(true)
                case .fill2:
                    FillHeightScreen(path: $path)
                        .navigationBarBackButtonHidden(true)
                case .fill3:
                    FillAgeScreen(path: $path)
                        .navigationBarBackButtonHidden(true)
                case .fill4:
                    FillLvlActivityScreen(path: $path)
                        .navigationBarBackButtonHidden(true)
                case .fill5:
                    FillSkillScreen(path: $path)
                        .navigationBarBackButtonHidden(true)
                case .main:
                    MainScreen(viewModel: mainViewModel, authMain: authMain, path: $path)
                        .navigationBarBackButtonHidden(true)
                case .exerciseDetails(let item):
                    ExerciseDetailsScreen(viewModel: .init(id: item.id, title: item.title, image: item.image, description: item.description), path: $path)
                        .navigationBarBackButtonHidden(true)
                case .acc:
                    AccountScreen(viewModel: authMain, path: $path)
                        .navigationBarBackButtonHidden(true)
                case .root:
                    RootScreen(viewModel: authMain, path: $path)
                        .navigationBarBackButtonHidden(true)
                }
            }
            .environmentObject(authMain)
        }
        .onAppear {
            viewModel.loadData()
        }
    }
}

#Preview {
    FirstOnboardingScreen(viewModel: .init())
}


