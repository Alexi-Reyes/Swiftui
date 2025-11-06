import SwiftUI
import DesignSystem

let allTypesFilter = "All Types"

struct HomeView: View {
    @State var pokemonViewModel = PokemonViewModel()
    @State private var searchText = ""
    @State private var selectedType = allTypesFilter
    @State private var pokemonTypes = PokemonType.allCases.map { $0.rawValue }
    
    var filteredPokemon: [Pokemon] {
        pokemonViewModel.pokemonList.filter { pokemon in
            let matchesSearchText = searchText.isEmpty || pokemon.name.localizedCaseInsensitiveContains(searchText)
            
            let matchesTypeFilter: Bool
            
            if selectedType == allTypesFilter {
                matchesTypeFilter = true
            } else {
                if let details = pokemonViewModel.pokemonDetails[pokemon.name] {
                    matchesTypeFilter = details.types.contains { typeSlot in
                        typeSlot.type.name == selectedType
                    }
                } else {
                    matchesTypeFilter = true
                }
            }
            
            return matchesSearchText && matchesTypeFilter
        }
    }

    var body: some View {
        Text("Pokédex")
            .fontWeight(.bold)
        SearchBar(searchText: $searchText, selectedType: $selectedType, types: $pokemonTypes)
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
                if pokemonViewModel.pokemonDetails[pokemon.name] != nil {
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
