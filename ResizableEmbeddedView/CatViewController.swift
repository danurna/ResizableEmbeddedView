import SwiftUI
import UIKit

struct UIViewControllerCatsView: UIViewControllerRepresentable {
    typealias UIViewControllerType = CatViewController
    
    func makeUIViewController(context: Context) -> CatViewController {
        CatViewController()
    }

    func updateUIViewController(_ uiViewController: CatViewController, context: Context) {}
}

class CatViewController: UIViewController {
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            titleLabel,
            catsView
        ])
        stackView.axis = .vertical
        stackView.distribution = .fill
        return stackView
    }()
    
    lazy var catsView: CatsUIView = {
        let catsView = CatsUIView()
        
        // Experiment: Disable this and compare it running on iOS 14 and iOS 15
        catsView.setContentCompressionResistancePriority(.required, for: .vertical)
        
        return catsView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Cat fact:\nAs of 2021, there were an estimated 220 million owned and 480 million stray cats in the world."
        label.numberOfLines = 0
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        stackView.widthAnchor.constraint(equalToConstant: 256).isActive = true
        stackView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
    }
}
