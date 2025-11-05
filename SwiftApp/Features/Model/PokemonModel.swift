import Foundation
import SwiftUI

struct Pokemon: Codable, Identifiable {
    var id: String { name }
    let name: String
    let url: String
}
