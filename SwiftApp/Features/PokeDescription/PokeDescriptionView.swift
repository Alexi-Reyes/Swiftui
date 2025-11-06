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
                HeaderPokeDescriptionView()
                Spacer()

                AboutPokeView()
                    .frame(height: geometry.size.height * 0.5)
                    .offset(y: geometry.size.height * 0.5)
                
                ImagePokemonView()
                    .offset(y: geometry.size.height * 0.27)
            }
//            List(pokeDescriptionViewModel.types) {
//                
//            }
        }
    }
}


#Preview {
    PokeDescriptionView()
}
