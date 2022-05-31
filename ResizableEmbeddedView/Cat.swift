import Foundation

struct Cat {
    let name: String
    let favoriteFood: String
}

extension Cat {
    static let famousCats: [Cat] = [
        Cat(
            name: "Dixie",
            favoriteFood: "Catnip 🪴"
        ),
        Cat(
            name: "Bruno",
            favoriteFood: "Peanuts 🥜"
        ),
        Cat(
            name: "Mitzi",
            favoriteFood: "Squid 🐙"
        )
    ]
}
