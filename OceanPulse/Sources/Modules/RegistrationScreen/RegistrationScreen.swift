
import SwiftUI

struct RegistrationScreen: View {
    @State private var mail = ""
    @State private var nick = ""
    @State private var pass = ""
    @State private var confirmPass = ""
    
    @State private var isNotificationShown = false
    @State private var isAlertShown = false
    
    @ObservedObject var viewModel: AuthMain
    @Binding var path: NavigationPath
    
    init(viewModel: AuthMain, path: Binding<NavigationPath>) {
        self.viewModel = viewModel
        self._path = path
    }
    
    var body: some View {
        VStack {            
            TextField("", text: $nick, prompt: Text("Name").foregroundColor(Color.init(red: 127/255, green: 137/255, blue: 149/255)).font(.system(size: 22, weight: .regular, design: .default)))
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
                .padding(.top, 4)
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
            
            SecureField("", text: $confirmPass, prompt: Text("Confirm password").foregroundColor(Color.init(red: 127/255, green: 137/255, blue: 149/255)).font(.system(size: 22, weight: .regular, design: .default)))
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
                if isFormValid {
                    Task {
                        do {
                            try await viewModel.createUser(withEmail: mail, password: pass, name: nick)
                            if !viewModel.text.isEmpty {
                                isAlertShown = true
                            }
                        } catch {
                            isAlertShown = true
                        }
                    }
                } else {
                    isNotificationShown.toggle()
                }
            } label: {
                Text("Register")
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
        }
    }
}

#Preview {
    RegistrationScreen(viewModel: .init(), path: .constant(.init()))
}


extension RegistrationScreen: AuthCoreProtocol {
    var isFormValid: Bool {
        return !mail.isEmpty
        && mail.contains("@")
        && !pass.isEmpty
        && pass.count > 5
        && confirmPass == pass
    }
}
