import Foundation
import SwiftUI

@Observable
class PokemonViewModel {
    var counterId: Int = 1
    var pokemonsResponse: Pokemons?
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
            pokemonsResponse = decoded
        } catch {
            print("Error fetching data: \(error)")
        }
    }
}
