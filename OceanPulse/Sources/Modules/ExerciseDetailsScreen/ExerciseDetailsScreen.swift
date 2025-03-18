
import SwiftUI

struct ExerciseDetailsScreen: View {
    @ObservedObject var viewModel: ExerciseDetailsViewModel
    @Binding var path: NavigationPath
    @Environment(\.dismiss) var dismiss
    
    @State private var isRunning = false
    @State private var elapsedTime: TimeInterval = 0
    @State private var timer: Timer?
    
    init(viewModel: ExerciseDetailsViewModel, path: Binding<NavigationPath>) {
        self.viewModel = viewModel
        self._path = path
    }
    
    var body: some View {
        VStack {
            HStack {
                Button { dismiss() } label: {
                    Image(.arrow)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .foregroundStyle(Color(red: 10/255, green: 15/255, blue: 12/255))
                }
                .padding(.trailing, 12)
                
                Text(viewModel.title)
                    .foregroundStyle(.black)
                    .font(.system(size: 24, weight: .semibold))
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                Spacer()
            }
            .padding(.horizontal, 24)
            .padding(.top, 48)
            
            Image(viewModel.image)
                .resizable()
                .scaledToFit()
                .padding(.horizontal, 24)
            
            ScrollView {
                Text(viewModel.description)
                    .foregroundStyle(Color(red: 31/255, green: 30/255, blue: 50/255))
                    .font(.system(size: 18, weight: .regular))
            }
            .padding(.horizontal, 24)
            
            VStack(spacing: 0) {
                Text(timeString(from: elapsedTime))
                    .foregroundStyle(.white)
                    .font(.system(size: 52, weight: .thin))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                
                HStack {
                    Button(action: toggleTimer) {
                        Text(isRunning ? "Stop" : "Start")
                            .padding(.vertical, 12)
                            .frame(maxWidth: .infinity)
                            .foregroundStyle(.white)
                            .font(.system(size: 26, weight: .semibold))
                    }
                    .background(isRunning
                                ? Color.init(red: 255/255, green: 132/255, blue: 61/255)
                                : Color.init(red: 129/255, green: 255/255, blue: 61/255)
                    )
                    .cornerRadius(24)
                    
                    Button(action: resetTimer) {
                        Text("Reset")
                            .padding(.vertical, 12)
                            .frame(maxWidth: .infinity)
                            .foregroundStyle(.white)
                            .font(.system(size: 26, weight: .semibold))
                    }
                    .background(Color(red: 255/255, green: 71/255, blue: 61/255))
                    .cornerRadius(24)
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 24)
            }
            .background(LinearGradient(colors: [
                Color(red: 15/255, green: 19/255, blue: 24/255),
                Color(red: 32/255, green: 40/255, blue: 51/255)
            ], startPoint: .leading, endPoint: .trailing))
            .clipShape(RoundedCorner(radius: 20, corners: [.topLeft, .topRight]))
        }
        .ignoresSafeArea()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Image(.mainBackground)
                .resizable()
                .ignoresSafeArea()
        )
    }
    
    private func toggleTimer() {
        if isRunning {
            timer?.invalidate()
            timer = nil
        } else {
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                elapsedTime += 1
            }
        }
        isRunning.toggle()
    }
    
    private func resetTimer() {
        timer?.invalidate()
        timer = nil
        elapsedTime = 0
        isRunning = false
    }
    
    private func timeString(from interval: TimeInterval) -> String {
        let hours = Int(interval) / 3600
        let minutes = (Int(interval) % 3600) / 60
        let seconds = Int(interval) % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
}


#Preview {
    ExerciseDetailsScreen(viewModel: .init(id: "1", title: "123", image: "123", description: "fds"), path: .constant(.init()))
}
