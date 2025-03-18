
import SwiftUI

struct MainScreen: View {
    @ObservedObject private var viewModel: MainViewModel
    @ObservedObject var authMain: AuthMain
    @Binding var path: NavigationPath
    let date = Date()
    
    init(viewModel: MainViewModel, authMain: AuthMain, path: Binding<NavigationPath>) {
        self.viewModel = viewModel
        self.authMain = authMain
        self._path = path
    }
    
    var body: some View {
        VStack {
            ZStack(alignment: .bottom) {
                VStack(alignment: .leading) {
                    Button {
                        path.append(Routing.acc)
                    } label: {
                        HStack {
                            Image(.accIcon)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                            Text("Profile")
                                .foregroundStyle(Color.init(red: 15/255, green: 19/255, blue: 24/255))
                                .font(.system(size: 18, weight: .light, design: .default))
                                .padding(4)
                        }
                    }
                    .background(Color.init(red: 197/255, green: 211/255, blue: 228/255))
                    .cornerRadius(24)
                    
                    HStack {
                        Text(dateFormatted(date: date, format: "EEEE"))
                            .foregroundStyle(Color.init(red: 35/255, green: 40/255, blue: 49/255))
                            .font(.system(size: 32, weight: .medium, design: .default))
                        Spacer()
                        Text(dateFormatted(date: date, format: "dd.MM.yyyy"))
                            .foregroundStyle(Color.init(red: 109/255, green: 125/255, blue: 146/255))
                            .font(.system(size: 22, weight: .regular, design: .default))
                    }
                    
                    ScrollView {
                        ForEach(viewModel.items, id: \.self) { item in
                            ItemView(viewModel: item) { item in
                                path.append(Routing.exerciseDetails(item))
                            }
                        }
                        .padding(.bottom, 92)
                    }
                    .scrollIndicators(.hidden)
                    Spacer()
                }
                
                MainCustomSwitcher(selectedOption: $viewModel.category)
                    .padding(.bottom, 18)
            }
        }
        .padding(.horizontal, 24)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Image(.mainBackground)
                .resizable()
                .ignoresSafeArea()
        )
        .onAppear {
            let savedCategory = UserDefaults.standard.string(forKey: "selectedCategory")
            let category = Category(rawValue: savedCategory ?? "") ?? .easy
            viewModel.category = category
            if viewModel.items.isEmpty {
                loadData()
            }
        }
        .onChange(of: viewModel.category) { _ in
            loadData()
        }
    }
    
    func loadData() {
        switch viewModel.category {
        case .easy:
            viewModel.easyLoadData()
        case .medium:
            viewModel.mediumLoadData()
        case .hard:
            viewModel.hardLoadData()
        }
    }

    func dateFormatted(date: Date, format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = Locale(identifier: "en_US")
        return formatter.string(from: date)
    }
}


#Preview {
    MainScreen(viewModel: .init(items: [], category: .easy), authMain: .init(), path: .constant(.init()))
}


struct MainCustomSwitcher: View {
    @Binding var selectedOption: Category
    
    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 48)
                .fill(Color(red: 197/255, green: 211/255, blue: 228/255))
                .frame(height: 60)
            
            GeometryReader { geo in
                RoundedRectangle(cornerRadius: 48)
                    .fill(Color(red: 255/255, green: 71/255, blue: 61/255))
                    .frame(width: geo.size.width / 3, height: 60)
                    .offset(x: getOffset(width: geo.size.width))
                    .animation(.easeInOut(duration: 0.3), value: selectedOption)
            }
            
            HStack {
                ForEach(Category.allCases, id: \.self) { option in
                    Button(action: {
                        withAnimation {
                            selectedOption = option
                        }
                    }) {
                        Text(option.rawValue)
                            .font(.system(size: 22, weight: .semibold))
                            .frame(maxWidth: .infinity)
                            .foregroundColor(selectedOption == option ? .white : Color(red: 15/255, green: 19/255, blue: 24/255))
                    }
                }
            }
        }
        .frame(height: 60)
    }
    
    private func getOffset(width: CGFloat) -> CGFloat {
        switch selectedOption {
        case .easy:
            return 0
        case .medium:
            return width / 3
        case .hard:
            return (width / 3) * 2
        }
    }
}

