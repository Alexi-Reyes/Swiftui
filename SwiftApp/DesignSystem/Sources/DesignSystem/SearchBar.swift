import SwiftUI

public struct SearchBar: View {
    @Binding public var searchText: String
    @Binding public var selectedType: String
    @Binding public var types: [String]
    
    public init(searchText: Binding<String>, selectedType: Binding<String>, types: Binding<[String]>) {
        self._searchText = searchText
        self._selectedType = selectedType
        self._types = types
    }
    
    public var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.secondary)
            
            TextField("Search Pokémon...", text: $searchText)
                .autocorrectionDisabled(true)

            if !searchText.isEmpty {
                Button(action: {
                    searchText = ""
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.secondary)
                }
            }
        }
        .padding(8)
        .background(Color(.systemGray6))
        .cornerRadius(10)
        .padding(.horizontal)
        
        Picker("Filter by Type", selection: $selectedType) {
            ForEach(types, id: \.self) { type in
                Text(type.capitalized)
            }
        }
        .pickerStyle(.menu)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    SearchBar(searchText: .constant("Pikachu"), selectedType: .constant("Fire"), types: .constant(["Fire", "Water"]))
}
