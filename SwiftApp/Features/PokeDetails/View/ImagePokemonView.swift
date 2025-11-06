import SwiftUI

struct ImagePokemonView: View {
    @State var pokemonDetailViewModel = PokemonDetailViewModel()
    
    var body: some View {
        VStack(alignment: .center , spacing: 10){
            AsyncImage(url: pokemonDetailViewModel.pokemonDetail?.sprites.frontDefaultURL) { state in
                switch state {
                case .success(let image):
                    image
                        .resizable()
                case .failure(let error):
                    Text("Error: \(error)")
                case .empty:
                    Text("Empty")
                }
            }
            .frame(width: 250, height: 250)
//            AsyncImage(url: pokemonDetailViewModel.pokemonDetail?.sprites.frontDefaultURL)
//                .frame(width: 200, height: 200)
//                .scaledToFit()
            }
//            .frame(maxWidth: .infinity)
//            .background(.purple.opacity(0.9))
            .padding(.bottom, -20)
        
            .task {
                await pokemonDetailViewModel.fetchPokemonDetails(id: "gengar")
            }
    }
}

#Preview {
    PokeDescriptionView()
}
