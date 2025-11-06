import SwiftUI

@Observable

class PokeDescriptionViewModel {
    var pokeNames: String = "test name"
    var image: URL? = nil
    var types: [TypeModel] = []
    var id: String = ""
    var description: String = "big test"
    
    
}
