import SwiftUI

struct ImagePokemonView: View {
    @State var pokemonDetailViewModel = PokemonDetailViewModel()
    @State var pokeName: String = ""
    
    var body: some View {
        VStack(alignment: .center , spacing: 10){
            AsyncImage(url: pokemonDetailViewModel.pokemonDetail?.sprites.frontDefaultURL) { state in
                switch state {
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                case .failure(let error):
                    Text("Error: \(error)")
                case .empty:
                    Text("Empty")
                }
            }
            .frame(width: 250, height: 250)
        }
        .padding(.top, -60)
        .padding(.leading, 20)
        
            .task {
                await pokemonDetailViewModel.fetchPokemonDetails(pokeName: pokeName)
            }
    }
}

#Preview {
    PokeDescriptionView(pokeName: "gengar")
}
