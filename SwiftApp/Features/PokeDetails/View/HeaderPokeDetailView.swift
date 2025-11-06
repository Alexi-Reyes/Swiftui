import SwiftUI
import DesignSystem

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
                .padding(.bottom ,10)

            Text("\(pokemonDetailViewModel.pokemonDetail?.types.first?.type.name ?? "no type")")
                    .bold()
                    .font(.system(size: 25))
                    .pokemonTypeTagStyle(color: .fromPokemonType(pokemonDetailViewModel.pokemonDetail?.types.first?.type.name ?? "unknown"))
                Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Image(.detailBg).scaledToFit())
        .task {
            await pokemonDetailViewModel.fetchPokemonDetails(pokeName: pokeName)
        }
    }
    
    @ViewBuilder func background() -> any View {
        Image(.detailBg)
            .scaledToFit()
    }
}

#Preview {
    HeaderPokeDetailView(pokeName: "gengar")
}
