import SwiftUI

struct Pokemon: Codable, Identifiable {
    var id: String { name }
    let name: String
    let url: String
}

struct Pokemons: Decodable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [Pokemon]
}

struct PokemonDetail: Decodable {
    let name: String
    let abilities: [AbilityWrapper]
    let sprites: Sprites
    let types: [Type]
}

struct AbilityWrapper: Decodable {
    let ability: Ability
    let is_hidden: Bool
    let slot: Int
}

struct Ability: Decodable {
    let name: String
    let url: String
}

struct Type: Decodable {
    let slot: Int
    let type: TypeWrapper
}

struct TypeWrapper: Decodable {
    let name: String
    let url: String
}


struct Sprites: Decodable {
    private enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
    
    let frontDefault: String?
    
    var frontDefaultURL: URL? {
        guard let urlString = frontDefault else { return nil }
        return URL(string: urlString)
    }
}
