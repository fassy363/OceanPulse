
import SwiftUI

struct AuthorizationScreen: View {
    @State private var isSignInSelected = true
    @State private var mail = ""
    @State private var pass = ""
    
    @ObservedObject var viewModel: AuthMain
    @State private var isAlertShown = false
    @Binding var path: NavigationPath
    
    init(viewModel: AuthMain, path: Binding<NavigationPath>) {
        self.viewModel = viewModel
        self._path = path
    }
    
    var body: some View {
        VStack {
            Text("Let’s get you signed in!")
                .frame(maxWidth: .infinity, maxHeight: 100, alignment: .leading)
                .foregroundStyle(.white)
                .font(.system(size: 24, weight: .semibold, design: .default))
                .padding(.horizontal, 24)
                .padding(.bottom, 24)
                .background(LinearGradient(colors: [
                    Color.init(red: 15/255, green: 19/255, blue: 24/255),
                    Color.init(red: 32/255, green: 40/255, blue: 51/255)
                ], startPoint: .leading, endPoint: .trailing))
                .padding(.vertical, 8)
                .background(LinearGradient(colors: [
                    Color.init(red: 15/255, green: 19/255, blue: 24/255),
                    Color.init(red: 32/255, green: 40/255, blue: 51/255)
                ], startPoint: .leading, endPoint: .trailing))
                .clipShape(RoundedCorner(radius: 32, corners: [.bottomLeft, .bottomRight]))
            
            CustomSwitcher(isSignInSelected: $isSignInSelected)
                .padding(.top, -44)
            
            if isSignInSelected {
                TextField("", text: $mail, prompt: Text("Email").foregroundColor(Color.init(red: 127/255, green: 137/255, blue: 149/255)).font(.system(size: 22, weight: .regular, design: .default)))
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
                    .padding(.top, 50)
                    .padding(.horizontal, 24)
                
                SecureField("", text: $pass, prompt: Text("Password").foregroundColor(Color.init(red: 127/255, green: 137/255, blue: 149/255)).font(.system(size: 22, weight: .regular, design: .default)))
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
                
                Button {
                    Task {
                        do {
                            try await viewModel.signIn(email: mail, password: pass)
                            if !viewModel.text.isEmpty {
                                isAlertShown = true
                            }
                        } catch {
                            isAlertShown = true
                        }
                    }
                } label: {
                    Text("Login")
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .foregroundStyle(.white)
                        .font(.system(size: 28, weight: .bold, design: .default))
                        .lineLimit(1)
                }
                .background(Color.init(red: 10/255, green: 12/255, blue: 15/255))
                .cornerRadius(24)
                .padding(.top, 24)
                .padding(.horizontal, 24)
                
                Button {
                    Task {
                        await viewModel.signInAnonymously()
                    }
                } label: {
                    Text("Anonymous")
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .foregroundStyle(.white)
                        .font(.system(size: 28, weight: .bold, design: .default))
                        .lineLimit(1)
                }
                .background(Color.init(red: 10/255, green: 12/255, blue: 15/255))
                .cornerRadius(24)
                .padding(.top, 12)
                .padding(.horizontal, 24)
                Spacer()
            } else {
                RegistrationScreen(viewModel: viewModel, path: $path)
            }
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
    AuthorizationScreen(viewModel: .init(), path: .constant(.init()))
}


struct CustomSwitcher: View {
    @Binding var isSignInSelected: Bool
    let options = ["Sign in", "Register"]

    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 32)
                .fill(Color.init(red: 197/255, green: 211/255, blue: 228/255))
                .frame(height: 60)
            
            HStack {
                if !isSignInSelected {
                    Spacer()
                }
                RoundedRectangle(cornerRadius: 32)
                    .fill(Color.init(red: 255/255, green: 71/255, blue: 61/255))
                    .frame(width: UIScreen.main.bounds.width / 2.4, height: 60)
                if isSignInSelected {
                    Spacer()
                }
            }
            .animation(.easeInOut(duration: 0.3), value: isSignInSelected)

            HStack {
                ForEach(options, id: \.self) { option in
                    Button(action: {
                        withAnimation {
                            isSignInSelected = (option == "Sign in")
                        }
                    }) {
                        Text(option)
                            .font(.system(size: 22, weight: .semibold, design: .default))
                            .frame(maxWidth: .infinity)
                            .foregroundColor(isSignInSelected == (option == "Sign in")
                                             ? .white
                                             : Color.init(red: 15/255, green: 19/255, blue: 24/255))
                    }
                }
            }
        }
        .padding(.horizontal, 24)
    }
}
