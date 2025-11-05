import SwiftUI

struct ContentView: View {
    @State var pokemonViewModel = PokemonViewModel()

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        List(pokemonViewModel.pokemonList) { pokemon in
            Text(pokemon.name.capitalized)
        }
        .task {
            await pokemonViewModel.fetchPokemons(limit: 20)
        }
    }
}

#Preview {
    ContentView()
}
