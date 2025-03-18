
import SwiftUI
import RealmSwift

struct FillSkillScreen: View {
    @Binding var path: NavigationPath
    @Environment(\.dismiss) var dismiss
    @State private var selectedOption: String? = nil
    
    init(path: Binding<NavigationPath>) {
        self._path = path
    }
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("Fill out a profile")
                        .foregroundStyle(.white)
                        .font(.system(size: 24, weight: .semibold, design: .default))
                    Text("It could take a few minutes")
                        .foregroundStyle(Color.init(red: 109/255, green: 125/255, blue: 146/255))
                        .font(.system(size: 14, weight: .regular, design: .default))
                }
                Spacer()
                Text("5/5")
                    .foregroundStyle(Color.init(red: 109/255, green: 125/255, blue: 146/255))
                    .font(.system(size: 34, weight: .regular, design: .default))
            }
            .padding(24)
            .padding(.vertical, 12)
            .background(LinearGradient(colors: [
                Color.init(red: 15/255, green: 19/255, blue: 24/255),
                Color.init(red: 32/255, green: 40/255, blue: 51/255)
            ], startPoint: .leading, endPoint: .trailing))
            .clipShape(RoundedCorner(radius: 32, corners: [.bottomLeft, .bottomRight]))
            
            Text("What is your main target?")
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundStyle(Color.init(red: 35/255, green: 40/255, blue: 49/255))
                .font(.system(size: 32, weight: .medium, design: .default))
                .minimumScaleFactor(0.5)
                .lineLimit(1)
                .padding(.horizontal, 24)
                .padding(.top, 24)
            FillItem(image: "skill1", text: "Learn to surf", category: .easy, selectedOption: $selectedOption)
                .padding(.horizontal, 24)
            FillItem(image: "skill2", text: "Improve technique", category: .medium, selectedOption: $selectedOption)
                .padding(.horizontal, 24)
            FillItem(image: "skill3", text: "Get ready for the competition", category: .hard, selectedOption: $selectedOption)
                .padding(.horizontal, 24)
            Spacer()
            HStack(spacing: 24) {
                Button {
                    dismiss()
                } label: {
                    Image(.arrow)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .foregroundStyle(Color.init(red: 10/255, green: 15/255, blue: 12/255))
                }
                
                Button {
                    if selectedOption != nil {
                        path.append(Routing.onb4)
                        UserDefaults.standard.set(selectedOption, forKey: "category")
                    }
                } label: {
                    Text("Next")
                        .padding(.vertical, 16)
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(.white)
                        .font(.system(size: 28, weight: .medium, design: .default))
                }
                .background(Color.init(red: 10/255, green: 12/255, blue: 15/255))
                .cornerRadius(24)
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 32)
        }
        .ignoresSafeArea()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Image(.onboardingBackground)
                .resizable()
                .ignoresSafeArea()
        )
    }
}

#Preview {
    FillSkillScreen(path: .constant(.init()))
}
