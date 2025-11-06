import SwiftUI

struct AboutPokeView: View {
    @State var pokemonDetailViewModel = PokemonDetailViewModel()
    @State var pokeName: String = ""
    
    var body: some View {
        VStack(spacing: 10){
            //                Text("\(pokemonDetailViewModel.pokemonDetail?.description)")
            //                    .padding(.top)
            //                    .padding(.leading)
            //                    .padding(.bottom)
            //                    .frame(maxWidth: .infinity, alignment: .center)
            //                    .background(Color.gray.opacity(0.4))
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(minimum: 100), alignment: .leading), count: 2), spacing: 2){
                ForEach(pokemonDetailViewModel.displayableDic, id: \.0) { value, key in
                    buildAttribute(text:value, text2: key)
                        .padding(2)
                        .cornerRadius(15)
                }
                .padding()
            }
            .padding(.top, 20)
        }
        .background(.white)
//        .cornerRadius(25)
        .task {
            await pokemonDetailViewModel.fetchPokemonDetails(pokeName: pokeName)
        }
    }
    
    @ViewBuilder
    func buildAttribute(text: String, text2: String) -> some View {
        //        HStack (alignment: .center, spacing: 0){
        Text(text)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading)
//            .background(.red)
        Text(text2)
            .frame(maxWidth: .infinity, alignment: .center)
//            .background(.blue)
        //        }
    }
}


#Preview {
    AboutPokeView()
        .frame(width: 300)
}
