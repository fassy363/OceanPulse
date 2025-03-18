
import SwiftUI

struct RootScreen: View {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @Binding var path: NavigationPath
    @ObservedObject var viewModel: AuthMain
    @StateObject private var mainViewModel = MainViewModel(items: [], category: .easy)

    init(viewModel: AuthMain, path: Binding<NavigationPath>) {
        self.viewModel = viewModel
        self._path = path
    }

    var body: some View {
        if viewModel.userSession != nil {
            if viewModel.isNewUser {
                SecondOnboardingScreen(path: $path)
            } else {
                MainScreen(viewModel: mainViewModel, authMain: viewModel, path: $path)
            }
        } else {
            AuthorizationScreen(viewModel: viewModel, path: $path)
        }
    }
}


#Preview {
    RootScreen(viewModel: .init(), path: .constant(.init()))
}
