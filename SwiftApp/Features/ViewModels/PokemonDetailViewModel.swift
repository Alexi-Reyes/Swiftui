import SwiftUI

@MainActor
@Observable
class PokemonDetailViewModel {
    var pokemonDetail: PokemonDetail? {
        didSet {
            guard let pokemonDetail else { return }
            displayableDic = [(String, String)]()
            displayableDic.append(("ability :", pokemonDetail.abilities.map { $0.ability.name }.joined(separator: ", ") ?? ""))
            displayableDic.append(("Hp :", "\(pokemonDetail.stats[0].base_stat)"))
//            displayableDic.append(("Hp :", "\(pokemonDetail?.stats[0].base_stat ?? 0) "))
            displayableDic.append(("Attack :", "\(pokemonDetail.stats[1].base_stat)"))
            displayableDic.append(("Defense :", "\(pokemonDetail.stats[2].base_stat)"))
            displayableDic.append(("Special defense :", "\(pokemonDetail.stats[4].base_stat)"))
            displayableDic.append(("Spacial attack :", "\(pokemonDetail.stats[3].base_stat)"))
            displayableDic.append(("Speed :", "\(pokemonDetail.stats[5].base_stat)"))
        }
    }
    var pokeName = ""
    var displayableDic = [(String, String)]()

    func fetchPokemonDetails(pokeName: String) async {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(pokeName)") else {
            print("Invalid URL")
            return
        }
        do {
            let(data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                return
            }
            
            let decoded = try JSONDecoder().decode(PokemonDetail.self, from: data)
            pokemonDetail = decoded
        } catch {
            print("Error fetching data: \(error)")
        }
    }
}
