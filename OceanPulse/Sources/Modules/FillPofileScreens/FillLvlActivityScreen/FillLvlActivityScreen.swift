
import SwiftUI

struct FillLvlActivityScreen: View {
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
                Text("4/5")
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
            
            Text("What is your level of physical activity?")
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundStyle(Color.init(red: 35/255, green: 40/255, blue: 49/255))
                .font(.system(size: 32, weight: .medium, design: .default))
                .padding(.horizontal, 24)
                .padding(.top, 24)
            
            FillItem(image: "lvlActivity1", text: "I don't do anything", category: .easy, selectedOption: $selectedOption)
                .padding(.horizontal, 24)
            FillItem(image: "lvlActivity2", text: "Work out occasionally", category: .medium, selectedOption: $selectedOption)
                .padding(.horizontal, 24)
            FillItem(image: "lvlActivity3", text: "Active lifestyle", category: .hard, selectedOption: $selectedOption)
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
                        path.append(Routing.fill5)
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
                .disabled(selectedOption == nil)
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
    FillLvlActivityScreen(path: .constant(.init()))
}


struct FillItem: View {
    let image: String
    let text: String
    let category: Category
    @Binding var selectedOption: String?
    
    var body: some View {
        HStack {
            Image(image)
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
            
            Text(text)
                .padding(.vertical, 16)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundStyle(.white)
                .font(.system(size: 22, weight: .medium, design: .default))
            
            Spacer()
        }
        .padding(.horizontal, 12)
        .background(selectedOption == text
                    ? Color.init(red: 131/255, green: 140/255, blue: 150/255)
                    : Color.init(red: 31/255, green: 40/255, blue: 50/255)
        )
        .cornerRadius(12)
        .onTapGesture {
            selectedOption = text
            UserDefaults.standard.set(category.rawValue, forKey: "selectedCategory")
        }
        .animation(.easeInOut(duration: 0.2), value: selectedOption)
    }
}
