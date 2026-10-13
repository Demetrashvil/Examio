import Foundation

struct LiteraryWork: Decodable, Identifiable {
    let id: Int
    let title: String
    let author: String
    let description: String
    let chapters: [Chapter]
}
