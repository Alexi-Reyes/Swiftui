import SwiftUI

public struct Pokemon: Codable, Identifiable {
    public var id: String { name }
    public let name: String
    public let url: String
}

public struct Pokemons: Decodable {
    public let count: Int
    public let next: String?
    public let previous: String?
    public let results: [Pokemon]
}

public struct PokemonDetail: Decodable {
    let id: Int
    let name: String
    let abilities: [AbilityWrapper]
    let sprites: Sprites
    let types: [Type]
    let stats: [Stat]
}

public struct AbilityWrapper: Decodable {
    let ability: Ability
    let is_hidden: Bool
    let slot: Int
}

public struct Ability: Decodable {
    let name: String
    let url: String
}

public struct Type: Decodable {
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

protocol PokemonFetching {
    func fetchPokemons(limit: Int) async throws -> Pokemons
    func fetchPokemon(url: String) async throws -> PokemonDetail
}

struct Stat: Decodable {
    let base_stat: Int
    let effort: Int
}
