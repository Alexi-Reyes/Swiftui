import SwiftUI

struct HeaderPokeDetailView: View {
    @State var pokemonDetailViewModel = PokemonDetailViewModel()
    
    var body: some View {
        VStack(spacing: 10){
            HStack(alignment: .top){
                Text("\(pokemonDetailViewModel.id)")
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
            await pokemonDetailViewModel.fetchPokemonDetails(id: pokemonDetailViewModel.id)
        }
    }
}

#Preview {
    HeaderPokeDetailView()
}
