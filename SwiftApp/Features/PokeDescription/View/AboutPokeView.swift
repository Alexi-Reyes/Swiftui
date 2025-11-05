import SwiftUI

struct AboutPokeView: View {
    @State var pokeDescriptionViewModel = PokeDescriptionViewModel()
    
    var body: some View {
        VStack(spacing: 10){
            Spacer()
            VStack(alignment: .leading){
                Text("Description: \(pokeDescriptionViewModel.description)")
                    .padding(.top)
                    .padding(.leading)
                    .padding(.bottom)
                
                HStack (spacing: 20){
                    VStack(alignment: .leading, spacing: 20){
                        Text("Speciality: ")
                        Text("Ability: ")
                        Text("Capacity1 : ")
                        Text("Capacity2 : ")
                        Text("Capacity3 : ")
                    }
                    .padding(.leading)
                    
                    VStack(alignment: .leading, spacing: 20){
                        Text("Dragon")
                        Text("Taper")
                        Text("1")
                        Text("2")
                        Text("3")
                    }
                    .padding(.horizontal)
                    
                }
                Spacer()
            }
            .background(.gray)
            .padding(.top, 20)
//            .frame(width: .infinity, height: .infinity)
            .frame(maxWidth: .infinity)
        }
        .background(.orange)
        .cornerRadius(25)
        .ignoresSafeArea()
//        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}


#Preview {
    AboutPokeView()
        .frame(width: 300, height: 500)
}
