
import SwiftUI

struct SecondOnboardingScreen: View {
    @Binding var path: NavigationPath
    
    init(path: Binding<NavigationPath>) {
        self._path = path
    }
    
    var body: some View {
        VStack {
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            Text("Welcome to our")
                .foregroundStyle(Color.init(red: 156/255, green: 175/255, blue: 198/255))
                .font(.system(size: 24, weight: .bold, design: .default))
            Text("AI Assistant")
                .foregroundStyle(Color.init(red: 255/255, green: 71/255, blue: 61/255))
                .font(.system(size: 56, weight: .heavy, design: .default))
            Text("Tell us a little about yourself!\nFill in your basic details so we can tailor the app to your needs.")
                .foregroundStyle(Color.init(red: 109/255, green: 125/255, blue: 146/255))
                .font(.system(size: 16, weight: .regular, design: .default))
                .multilineTextAlignment(.center)
            Spacer()
            Button {
                path.append(Routing.fill1)
            } label: {
                Text("Fill out a profile")
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
            Image(.secondOnboardingBackground)
                .resizable()
                .ignoresSafeArea()
        )
    }
}

#Preview {
    SecondOnboardingScreen(path: .constant(.init()))
}
