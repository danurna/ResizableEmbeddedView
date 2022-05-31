import Foundation
import SwiftUI
import UIKit

class CatsUIView: UIView {
    private var catsView: CatsView?
    private var hostingViewController: UIViewController?
    
    init() {
        super.init(frame: .zero)
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        guard hostingViewController == nil else { return }
        
        let catsView = CatsView.init(.init(onSizeChange: { [weak self] in
            // Experiment: Comment this out to see what's going wrong
            self?.invalidateIntrinsicContentSize()
        }))
        self.catsView = catsView
        hostingViewController = UIHostingController(rootView: catsView)
        
        guard let embeddedCatsView = hostingViewController?.view else { return }
        
        // Pin view to edges of hosting view
        embeddedCatsView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(embeddedCatsView)
        [
            embeddedCatsView.topAnchor.constraint(equalTo: topAnchor),
            embeddedCatsView.bottomAnchor.constraint(equalTo: bottomAnchor),
            embeddedCatsView.leadingAnchor.constraint(equalTo: leadingAnchor),
            embeddedCatsView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ].forEach { $0.isActive = true }
        
        // Color to highlight embedded view boundaries
        embeddedCatsView.backgroundColor = .green.withAlphaComponent(0.1)
        embeddedCatsView.layer.cornerRadius = 6.0
    }

    override var intrinsicContentSize: CGSize {
        return hostingViewController?.view.intrinsicContentSize ?? .zero
    }
}
