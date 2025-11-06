import SwiftUI


struct PokeDescriptionView: View {
    @State var pokeDescriptionViewModel = PokeDescriptionViewModel()
    @State var pokeName: String = ""
    @State var pokeImage: URL? = nil
    @State var pokeType: String = ""
    @State var pokeDescription: String = ""
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .top){
                HeaderPokeDetailView(pokeName: pokeName)
                Spacer()

                AboutPokeView(pokeName: pokeName)
                    .frame(height: geometry.size.height * 0.55)
                    .clipShape(RoundedRectangle(cornerRadius: 25))
//                    .background(.red)
                    .offset(y: geometry.size.height * 0.5)
                ImagePokemonView(pokeName: pokeName)
                    .offset(y: geometry.size.height * 0.26)
            }
//            List(pokeDescriptionViewModel.types) {
//                
//            }
        }
    }
}


#Preview {
    PokeDescriptionView(pokeName: "gengar")
}
