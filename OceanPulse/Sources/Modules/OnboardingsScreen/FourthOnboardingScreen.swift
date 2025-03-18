
import SwiftUI

struct FourthOnboardingScreen: View {
    @Binding var path: NavigationPath
    
    init(path: Binding<NavigationPath>) {
        self._path = path
    }
    
    var body: some View {
        VStack {
            Spacer()
            Text("Waiting for")
                .foregroundStyle(Color.init(red: 156/255, green: 175/255, blue: 198/255))
                .font(.system(size: 24, weight: .bold, design: .default))
            Text("Loading...")
                .foregroundStyle(Color.init(red: 255/255, green: 71/255, blue: 61/255))
                .font(.system(size: 56, weight: .heavy, design: .default))
                .padding(.bottom, 74)
        }
        .padding(.horizontal, 24)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Image(.fourthOnboardingBackground)
                .resizable()
                .ignoresSafeArea()
        )
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                path.append(Routing.main)
            }
        }
    }
}

#Preview {
    FourthOnboardingScreen(path: .constant(.init()))
}
