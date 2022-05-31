import SwiftUI

struct CatsView: View {
    @ObservedObject var viewModel: ViewModel
    
    init(_ viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Text("Furry friends")
                    .font(.callout)
                    .foregroundColor(.accentColor)
                    .multilineTextAlignment(.leading)
                    .padding()
                Spacer()
                Image(systemName: "chevron.right")
                    .font(.system(size: 11, weight: .bold))
                    .foregroundColor(.accentColor)
                    .rotationEffect(.degrees(viewModel.collapsed ? 0 : 90))
                    .padding([.trailing], 10)
            }
            .contentShape(Rectangle())
            .onTapGesture {
                // Experiment: Enable animations and see how both implementations behave
//                withAnimation() {
                    viewModel.headerTapped()
//                }
            }
            
            if !viewModel.collapsed {
                Group {
                    ForEach(viewModel.cats, id: \.name) { cat in
                        CellLikeField(
                            title: cat.name,
                            content: cat.favoriteFood
                        )
                    }
                }
                .transition(.asymmetric(
                    insertion: .opacity.animation(.easeIn),
                    removal: .opacity
                ))
            }
        }
    }
    
    struct CellLikeField: View {
        let title: String
        let content: String
        
        var body: some View {
            VStack(alignment: .leading, spacing: 8.0) {
                HStack {
                    VStack(alignment: .leading) {
                        Text(title)
                            .font(.system(size: 14))
                            .kerning(0.25)
                            .foregroundColor(.black.opacity(0.8))
                        Text(content)
                            .font(.system(size: 16))
                            .kerning(0.5)
                            .foregroundColor(.black)
                    }
                    Spacer()
                }
            }
            .padding([.leading, .trailing])
            .padding([.top, .bottom], 12.0)
            .frame(maxWidth: .infinity)
        }
    }
}

extension CatsView {
    class ViewModel: ObservableObject {
        private let onSizeChange: (() -> Void)?
        @Published var collapsed: Bool
        
        let cats = Cat.famousCats
        
        init(onSizeChange: (() -> Void)?) {
            self.onSizeChange = onSizeChange
            collapsed = true
        }
        
        func headerTapped() {
            collapsed.toggle()
            
            // Dispatch to prevent size of this view
            // and hosting view not matching
            DispatchQueue.main.async {
                self.onSizeChange?()
            }
        }
    }
}
