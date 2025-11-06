import Foundation
import SwiftUI

@MainActor
@Observable
class PokemonViewModel {
    var counterId: Int = 1
    var pokemonsResponse: Pokemons?
    var pokemonDetails: [String: PokemonDetail] = [:]
    var limit: Int = 10
    
    private let fetcher: PokemonFetching
    
    init(fetcher: PokemonFetching = RealPokemonFetcher()) {
            self.fetcher = fetcher
        }
    
    var pokemonList: [Pokemon] {
        return pokemonsResponse?.results ?? []
    }
    
    func fetchPokemons(limit: Int) async {
        do {
            let decoded = try await fetcher.fetchPokemons(limit: limit)
            self.pokemonsResponse = decoded
        } catch {
            print("Error fetching data: \(error)")
        }
    }

    func fetchPokemon(for pokemon: Pokemon) async {
        do {
            let decoded = try await fetcher.fetchPokemon(url: pokemon.url)
            self.pokemonDetails[pokemon.name] = decoded
        } catch {
            print("Error on \(pokemon.name): \(error)")
        }
    }
}

class RealPokemonFetcher: PokemonFetching {
    func fetchPokemons(limit: Int) async throws -> Pokemons {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=\(limit)") else {
            throw URLError(.badURL)
        }
        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        return try JSONDecoder().decode(Pokemons.self, from: data)
    }

    func fetchPokemon(url: String) async throws -> PokemonDetail {
        guard let url = URL(string: url) else {
            throw URLError(.badURL)
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(PokemonDetail.self, from: data)
    }
}
