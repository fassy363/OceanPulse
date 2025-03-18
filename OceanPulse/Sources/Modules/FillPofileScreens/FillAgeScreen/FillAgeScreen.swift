
import SwiftUI

struct FillAgeScreen: View {
    @State private var age: String = ""
    @Binding var path: NavigationPath
    @Environment(\.dismiss) var dismiss
    
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
                Text("3/5")
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
            
            Text("Enter your age")
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundStyle(Color.init(red: 35/255, green: 40/255, blue: 49/255))
                .font(.system(size: 34, weight: .medium, design: .default))
                .padding(.horizontal, 24)
                .padding(.top, 24)
            TextField("", text: $age, prompt: Text("Tap to write").foregroundColor(Color.init(red: 127/255, green: 137/255, blue: 149/255)).font(.system(size: 22, weight: .regular, design: .default)))
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                .padding(18)
                .foregroundStyle(Color.init(red: 127/255, green: 137/255, blue: 149/255))
                .background {
                    Rectangle()
                        .foregroundColor(Color.init(red: 239/255, green: 244/255, blue: 250/255))
                        .cornerRadius(16)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.init(red: 181/255, green: 192/255, blue: 205/255), lineWidth: 1.5)
                        )
                }
                .padding(.top, 4)
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
                    path.append(Routing.onb3)
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
    FillAgeScreen(path: .constant(.init()))
}
