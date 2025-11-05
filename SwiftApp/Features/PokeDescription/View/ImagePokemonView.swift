import SwiftUI

struct ImagePokemonView: View {
    @State var pokeDescriptionViewModel = PokeDescriptionViewModel()
    
    var body: some View {
        VStack(alignment: .center , spacing: 10){
            AsyncImage(url: pokeDescriptionViewModel.image)
                .frame(width: 200, height: 200)
                .scaledToFit()
            }
//            .frame(maxWidth: .infinity)
            .background(.purple.opacity(0.9))
            .padding(.bottom, -20)
    }
}
