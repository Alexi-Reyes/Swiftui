import SwiftUI

public struct PokemonCard: View {
    public var name: String
    public var type1: String
    public var type2: String?
    public var imageURL: URL?
    
    public init(
        name: String = "name",
        type1: String = "type",
        type2: String? = nil,
        imageURL: URL? = nil
    ) {
        self.name = name
        self.type1 = type1
        self.type2 = type2
        self.imageURL = imageURL
    }
    
    public var body: some View {
        VStack(alignment: .center) {
            if let imageURL = imageURL {
                AsyncImage(url: imageURL) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                    } else {
                        Image(systemName: "xmark.octagon.fill")
                            .foregroundColor(.red)
                            .frame(width: 100, height: 100)
                    }
                }
            }
            Text(name)
                .font(.headline)
                .fontWeight(.bold)
            HStack(alignment: .center) {
                Text(type1)
                    .pokemonTypeTagStyle(color: .fromPokemonType(type1))
                if let secondType = type2 {
                    Text(secondType)
                        .pokemonTypeTagStyle(color: .fromPokemonType(type2 ?? ""))
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .center)
        .background(Color.fromPokemonType(type1).opacity(0.2))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.1), radius: 6, x: 0, y: 3)
        .padding()
    }
}

#Preview {
    PokemonCard(type1: "grass", type2: "fire")
}
