import SwiftUI

@main
struct ResizableEmbeddedViewApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

struct ContentView: View {
    var body: some View {
        VStack(spacing: 16.0) {
            Text("UIViewController w/ StackView")
                .font(.title2)
                .padding()
            UIViewControllerCatsView()
                .background(Color.pink.opacity(0.1))
                .cornerRadius(6.0)
            Text("SwiftUI")
                .font(.title2)
            HStack {
                Spacer()
                CatsView(.init(onSizeChange: {}))
                    .frame(maxWidth: 256)
                    .background(Color.orange.opacity(0.1))
                    .cornerRadius(6.0)
                    .padding([.top, .bottom])
                Spacer()
            }
            
        }
    }
}
