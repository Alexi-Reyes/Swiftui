enum PokemonType: String, CaseIterable, Identifiable {
    case allTypes = "All Types"
    case normal
    case fire
    case water
    case grass
    case electric
    case ice
    case fighting
    case poison
    case ground
    case flying
    case psychic
    case bug
    case rock
    case ghost
    case dragon
    case steel
    case fairy

    var id: String { self.rawValue }
    
    var displayName: String {
        return self.rawValue
    }
}
