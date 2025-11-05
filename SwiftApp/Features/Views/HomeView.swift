import SwiftUI
import DesignSystem

struct HomeView: View {
    @State var pokemonViewModel = PokemonViewModel()

    var body: some View {
        Text("Pokédex")
            .fontWeight(.bold)
        List(pokemonViewModel.pokemonList) { pokemon in
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
            await pokemonViewModel.fetchPokemons(limit: 20)
        }
    }
}

#Preview {
    HomeView()
}
