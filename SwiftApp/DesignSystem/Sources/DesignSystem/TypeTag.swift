import SwiftUI

struct TypeTagModifier: ViewModifier {
    let typeColor: Color
    
    func body(content: Content) -> some View {
        content
            .font(.caption)
            .fontWeight(.bold)
            .textCase(.uppercase)
            .foregroundColor(typeColor)
            .brightness(-0.5)
            .padding(.vertical, 4)
            .padding(.horizontal, 8)
            .background(typeColor)
            .border(Color.gray, width: 0.5)
            .cornerRadius(4)
    }
}

extension View {
    func pokemonTypeTagStyle(color: Color) -> some View {
        self.modifier(TypeTagModifier(typeColor: color))
    }
}

extension Color {
    static func fromPokemonType(_ type: String) -> Color {
        let normalizedType = type.lowercased()
        switch normalizedType {
        case "fire": return Color(red: 0.93, green: 0.30, blue: 0.19)
        case "grass": return Color(red: 0.48, green: 0.78, blue: 0.29)
        case "poison": return Color(red: 0.64, green: 0.23, blue: 0.63)
        case "electric": return Color(red: 0.97, green: 0.82, blue: 0.17)
        case "water": return Color(red: 0.21, green: 0.56, blue: 0.93)
        case "ground": return Color(red: 0.71, green: 0.50, blue: 0.26)
        case "flying": return Color(red: 0.90, green: 0.80, blue: 0.90)
        case "psychic": return Color(red: 0.90, green: 0.30, blue: 0.80)
        case "rock": return Color(red: 0.70, green: 0.40, blue: 0.30)
        case "ice": return Color(red: 0.90, green: 0.90, blue: 1.00)
        case "bug": return Color(red: 0.60, green: 0.80, blue: 0.20)
        case "dark": return Color(red: 0.40, green: 0.30, blue: 0.20)
        case "dragon": return Color(red: 0.70, green: 0.30, blue: 0.90)
        case "steel": return Color(red: 0.50, green: 0.50, blue: 0.50)
        case "fairy": return Color(red: 1.00, green: 0.80, blue: 1.00)
        default: return .gray
        }
    }
}
