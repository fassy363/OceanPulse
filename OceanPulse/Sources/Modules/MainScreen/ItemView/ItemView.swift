
import SwiftUI

struct ItemView: View {
    @ObservedObject private var viewModel: ItemViewModel
    var onTap: ((ItemViewModel) -> Void)?
    
    init(viewModel: ItemViewModel, onTap: ((ItemViewModel) -> Void)? = nil) {
        self.viewModel = viewModel
        self.onTap = onTap
    }
    var body: some View {
        HStack {
            Image(viewModel.image)
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 60)
                .padding(8)
            VStack {
                Text(viewModel.title)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundStyle(Color.init(red: 217/255, green: 224/255, blue: 234/255))
                    .font(.system(size: 16, weight: .semibold, design: .default))
                    .lineLimit(1)
                Text(viewModel.description)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundStyle(Color.init(red: 181/255, green: 192/255, blue: 205/255))
                    .font(.system(size: 12, weight: .regular, design: .default))
                    .lineLimit(1)
                Spacer()
            }
            Spacer()
        }
        .background(Color.init(red: 31/255, green: 40/255, blue: 50/255))
        .cornerRadius(18)
        .onTapGesture {
            onTap?(viewModel)
        }
    }
}

#Preview {
    ItemView(viewModel: .init(id: "1", image: "", title: "123", description: "asf"))
        .padding(24)
}
