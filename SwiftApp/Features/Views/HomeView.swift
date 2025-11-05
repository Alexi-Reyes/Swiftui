import SwiftUI
import DesignSystem

struct HomeView: View {
    @State var pokemonViewModel = PokemonViewModel()
    @State private var searchText = ""
    
    var filteredPokemon: [Pokemon] {
            if searchText.isEmpty {
                return pokemonViewModel.pokemonList
            } else {
                return pokemonViewModel.pokemonList.filter { pokemon in
                    pokemon.name.localizedCaseInsensitiveContains(searchText)
                }
            }
        }

    var body: some View {
        Text("Pokédex")
            .fontWeight(.bold)
        SearchBar(searchText: $searchText)
        List(filteredPokemon) { pokemon in
            let pokemonDetails = pokemonViewModel.pokemonDetails[pokemon.name]
            
            VStack(alignment: .leading) {
                PokemonCard(
                    name: pokemon.name.capitalized,
                    type1: pokemonDetails?.types.first?.type.name ?? "unknown",
                    type2: (pokemonDetails?.types.count ?? 0 > 1) ? pokemonDetails?.types.last?.type.name : nil,
                    imageURL: pokemonDetails?.sprites.frontDefaultURL,
                )
            }
            .task {
                if pokemonViewModel.pokemonDetails[pokemon.name] == nil {
                    await pokemonViewModel.fetchPokemon(for: pokemon)
                }
            }
        }
        .task {
            await pokemonViewModel.fetchPokemons(limit: 1000)
        }
    }
}

#Preview {
    HomeView()
}
