import Foundation
import RealmSwift

struct Exercise: Codable, Identifiable, Hashable {
    var bodyPart: String
    var equipment: String
    var gifUrl: String
    var id: String
    var name: String
    var target: String
}
