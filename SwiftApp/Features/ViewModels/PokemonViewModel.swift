import Foundation
import SwiftUI

@Observable
class PokemonViewModel {
    var counterId: Int = 1
    var pokemonsResponse: Pokemons?
    var pokemonDetails: [String: PokemonDetail] = [:]
    var limit: Int = 10
    
    var pokemonList: [Pokemon] {
        return pokemonsResponse?.results ?? []
    }
    
    func fetchPokemons(limit: Int) async {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=\(limit)") else {
            print("Invalid URL")
            return
        }
        do {
            let(data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                return
            }
            
            let decoded = try JSONDecoder().decode(Pokemons.self, from: data)
            
            await MainActor.run {
            self.pokemonsResponse = decoded
            }
        } catch {
            print("Error fetching data: \(error)")
        }
    }
    
    func fetchPokemon(for pokemon: Pokemon) async {
        guard let url = URL(string: pokemon.url) else {
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoded = try JSONDecoder().decode(PokemonDetail.self, from: data)
        
            await MainActor.run {
                self.pokemonDetails[pokemon.name] = decoded
            }
        } catch {
            print("Error on \(pokemon.name): \(error)")
        }
    }
}
