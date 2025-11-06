import SwiftUI

struct HeaderPokeDetailView: View {
    @State var pokemonDetailViewModel = PokemonDetailViewModel()
    @State var pokeName = ""
    
    var body: some View {
        VStack(spacing: 10){
            HStack(alignment: .top){
                Text(pokeName)
                    .font(.title)
                    .bold()
                    .padding(.leading)
                    .textCase(.uppercase)
//                    Spacer()
                }
                .frame(width: .infinity)
                .padding()

            Text("\(pokemonDetailViewModel.pokemonDetail?.types.first?.type.name ?? "no type")")
                    .padding(.leading)
                Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.green)
        .task {
            await pokemonDetailViewModel.fetchPokemonDetails(pokeName: pokeName)
        }
    }
}

#Preview {
    HeaderPokeDetailView(pokeName: "gengar")
}
