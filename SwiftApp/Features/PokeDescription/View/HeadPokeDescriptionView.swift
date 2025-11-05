import SwiftUI

struct HeaderPokeDescriptionView: View {
    @State var pokeDescriptionViewModel = PokeDescriptionViewModel()
    
    var body: some View {
        VStack(spacing: 10){
            HStack(alignment: .top){
                Text("\(pokeDescriptionViewModel.pokeNames)")
                    .font(.title)
                    .bold()
                    Spacer()
                }
                .frame(width: .infinity)
                .background(.gray)
                .padding()

                Text("\(pokeDescriptionViewModel.types)")
                    .padding(.leading)
                Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.green)
//                .position(x: geometry.size.width / 2, y: 0)
    }
}
