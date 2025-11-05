import SwiftUI

struct Pokemons: Decodable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [Pokemon]
}
