
import SwiftUI
import StoreKit

struct AccountScreen: View {
    @ObservedObject var viewModel: AuthMain
    @Binding var path: NavigationPath
    @Environment(\.dismiss) var dismiss
    @State private var showAlert = false
    
    init(viewModel: AuthMain, path: Binding<NavigationPath>) {
        self.viewModel = viewModel
        self._path = path
    }
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(.arrow)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .foregroundStyle(.white)
                }
                .padding(.trailing, 12)
                Text(viewModel.currentuser?.name ?? "")
                    .foregroundStyle(.white)
                    .font(.system(size: 34, weight: .regular, design: .default))
                Spacer()
            }
            .padding(24)
            .padding(.vertical, 12)
            .background(LinearGradient(colors: [
                Color.init(red: 15/255, green: 19/255, blue: 24/255),
                Color.init(red: 32/255, green: 40/255, blue: 51/255)
            ], startPoint: .leading, endPoint: .trailing))
            .clipShape(RoundedCorner(radius: 32, corners: [.bottomLeft, .bottomRight]))
            
            Text("Email")
                .foregroundStyle(Color.init(red: 35/255, green: 40/255, blue: 49/255))
                .font(.system(size: 30, weight: .semibold, design: .default))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 24)
                .padding(.top, 24)
            
            Text(viewModel.currentuser?.email ?? "")
                .foregroundStyle(Color.init(red: 109/255, green: 125/255, blue: 146/255))
                .font(.system(size: 28, weight: .thin, design: .default))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 24)
            
            Text("Password")
                .foregroundStyle(Color.init(red: 35/255, green: 40/255, blue: 49/255))
                .font(.system(size: 30, weight: .semibold, design: .default))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 24)
            
            Text("*************")
                .foregroundStyle(Color.init(red: 109/255, green: 125/255, blue: 146/255))
                .font(.system(size: 28, weight: .thin, design: .default))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 24)
            
            Spacer()
            
            Button {
                requestAppReview()
            } label: {
                Text("Rate an app")
                    .padding(.vertical, 16)
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(.white)
                    .font(.system(size: 26, weight: .medium, design: .default))
            }
            .background(.black)
            .cornerRadius(24)
            .padding(.horizontal, 24)
            
            Button {
                viewModel.signOut()
                dismiss()
            } label: {
                Text("Log out")
                    .padding(.vertical, 16)
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(.white)
                    .font(.system(size: 28, weight: .medium, design: .default))
            }
            .background(.black)
            .cornerRadius(24)
            .padding(.horizontal, 24)
            
            Button {
                showAlert = true
            } label: {
                Text("Delete account")
                    .padding(.vertical, 16)
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(.white)
                    .font(.system(size: 28, weight: .medium, design: .default))
            }
            .background(Color.init(red: 255/255, green: 71/255, blue: 61/255))
            .cornerRadius(24)
            .padding(.horizontal, 24)
            .padding(.bottom, 32)
            .alert("Are you sure?", isPresented: $showAlert) {
                Button("Delete", role: .destructive) {
                    viewModel.deleteUserAccount { result in
                        switch result {
                        case .success():
                            print("Account deleted successfully.")
                            viewModel.userSession = nil
                            viewModel.currentuser = nil
                            path = NavigationPath()
                        case .failure(let error):
                            print("ERROR DELELETING: \(error.localizedDescription)")
                        }
                    }
                }
                Button("Cancel", role: .cancel) {
                    
                }
            } message: {
                Text("Are you sure you want to delete the account?")
            }
//            Spacer()
        }
        .ignoresSafeArea()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Image(.mainBackground)
                .resizable()
                .ignoresSafeArea()
        )
    }
    
    func requestAppReview() {
       if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
           SKStoreReviewController.requestReview(in: scene)
       }
   }
}

#Preview {
    AccountScreen(viewModel: .init(), path: .constant(.init()))
}
