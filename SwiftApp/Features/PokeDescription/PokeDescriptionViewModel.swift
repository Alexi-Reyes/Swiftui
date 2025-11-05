import SwiftUI

@Observable

class PokeDescriptionViewModel {
    var pokeNames: String = "test name"
    var image: URL? = nil
    var types: [String] = []
    var id: String = ""
    var description: String = "big test"
    
    func getName(newName: String){
        pokeNames = newName
    }
    func getImage(newImage: URL?){
        image = newImage
    }
    func getId(newId: String){
        id = newId
    }
    func getDescription(newDescription: String){
        description = newDescription
    }
    
}
