import Testing
import SwiftUI
import Foundation

//todo importer les model de l application


//model

struct Pokemon: Codable, Identifiable {
    var id: String { name }
    let name: String
    let url: String
}

struct Pokemons: Decodable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [Pokemon]
}

struct PokemonDetail: Decodable {
    let id: Int
    let name: String
    let abilities: [AbilityWrapper]
    let sprites: Sprites
    let types: [Type]
}

struct AbilityWrapper: Decodable {
    let ability: Ability
    let is_hidden: Bool
    let slot: Int
}

struct Ability: Decodable {
    let name: String
    let url: String
}

struct Type: Decodable {
    let slot: Int
    let type: TypeWrapper
}

struct TypeWrapper: Decodable {
    let name: String
    let url: String
}

struct Sprites: Decodable {
    private enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
    
    let frontDefault: String?
    
    var frontDefaultURL: URL? {
        guard let urlString = frontDefault else { return nil }
        return URL(string: urlString)
    }
}

protocol PokemonFetching {
    func fetchPokemons(limit: Int) async throws -> Pokemons
    func fetchPokemon(url: String) async throws -> PokemonDetail
}

// fetcher

enum TestError: Error {
    case mockError
}

class MockPokemonFetcher: PokemonFetching {
    var pokemonsResult: Result<Pokemons, Error>?
    var pokemonDetailResult: Result<PokemonDetail, Error>?

    func fetchPokemons(limit: Int) async throws -> Pokemons {
        guard let result = pokemonsResult else {
            fatalError("pokemonsResult was not set for the test")
        }
        return try result.get()
    }

    func fetchPokemon(url: String) async throws -> PokemonDetail {
        guard let result = pokemonDetailResult else {
            throw TestError.mockError
        }
        return try result.get()
    }
}

class RealPokemonFetcher: PokemonFetching {
    func fetchPokemons(limit: Int) async throws -> Pokemons { throw URLError(.badURL) }
    func fetchPokemon(url: String) async throws -> PokemonDetail { throw URLError(.badURL) }
}

// viewmodel a tester
@MainActor
@Observable
class PokemonViewModel {
    var pokemonsResponse: Pokemons?
    var pokemonDetails: [String: PokemonDetail] = [:]
    
    private let fetcher: PokemonFetching
    
    init(fetcher: PokemonFetching = RealPokemonFetcher()) {
        self.fetcher = fetcher
    }
    
    var pokemonList: [Pokemon] {
        return pokemonsResponse?.results ?? []
    }
    
    func fetchPokemons(limit: Int) async {
        do {
            let decoded = try await fetcher.fetchPokemons(limit: limit)
            self.pokemonsResponse = decoded
        } catch {
        }
    }

    func fetchPokemon(for pokemon: Pokemon) async {
        do {
            let decoded = try await fetcher.fetchPokemon(url: pokemon.url)
            self.pokemonDetails[pokemon.name] = decoded
        } catch {
        }
    }
}

//tests

@Suite("Pokemon ViewModel Tests")
@MainActor
struct SwiftAppTests {
    private func makeTestPokemonDetail() -> (pokemon: Pokemon, detail: PokemonDetail) {
        let testPokemon1 = Pokemon(name: "bulbasaur", url: "url1")
        
        // mock
        let mockAbility = Ability(name: "test-ability", url: "url-ability")
        let mockAbilityWrapper = AbilityWrapper(ability: mockAbility, is_hidden: false, slot: 1)
        let mockSprites = Sprites(frontDefault: "url-sprite")
        let mockTypeWrapper = TypeWrapper(name: "test-type", url: "url-type")
        let mockType = Type(slot: 1, type: mockTypeWrapper)

        let testPokemonDetail1 = PokemonDetail(
            id: 1,
            name: "bulbasaur",
            abilities: [mockAbilityWrapper],
            sprites: mockSprites,
            types: [mockType]
        )
        return (testPokemon1, testPokemonDetail1)
    }


    @Test("Successful fetch of Pokemon list")
    func testFetchPokemons_Success() async throws {
        let (testPokemon1, _) = makeTestPokemonDetail()
        let mockFetcher = MockPokemonFetcher()
        
        let expectedPokemons = Pokemons(
            count: 1,
            next: nil,
            previous: nil,
            results: [testPokemon1]
        )
        
        mockFetcher.pokemonsResult = .success(expectedPokemons)
        let sut = PokemonViewModel(fetcher: mockFetcher)
        
        await sut.fetchPokemons(limit: 1)
        
        #expect(sut.pokemonList.count == 1)
        #expect(sut.pokemonList.first?.name == "bulbasaur")
    }

    @Test("Failed fetch of Pokemon list")
    func testFetchPokemons_Failure() async throws {
        let mockFetcher = MockPokemonFetcher()
        mockFetcher.pokemonsResult = .failure(TestError.mockError)
        
        let sut = PokemonViewModel(fetcher: mockFetcher)
        
        await sut.fetchPokemons(limit: 1)
        
        #expect(sut.pokemonList.isEmpty)
    }
    
    @Test("Successful fetch of single Pokemon details")
    func testFetchPokemonDetail_Success() async throws {
        let (testPokemon1, testPokemonDetail1) = makeTestPokemonDetail()
        let mockFetcher = MockPokemonFetcher()
        
        mockFetcher.pokemonDetailResult = .success(testPokemonDetail1)
        
        let sut = PokemonViewModel(fetcher: mockFetcher)
        
        await sut.fetchPokemon(for: testPokemon1)
        

        #expect(sut.pokemonDetails[testPokemon1.name]?.id == 1)
        #expect(sut.pokemonDetails.count == 1)
    }

    @Test("Failed fetch of single Pokemon's details")
    func testFetchPokemonDetail_Failure() async throws {
        let (testPokemon1, _) = makeTestPokemonDetail()
        let mockFetcher = MockPokemonFetcher()

        mockFetcher.pokemonDetailResult = .failure(TestError.mockError)

        let sut = PokemonViewModel(fetcher: mockFetcher)
        
        await sut.fetchPokemon(for: testPokemon1)
        
        #expect(sut.pokemonDetails.isEmpty, "Should not store detail on failure")
    }
}
