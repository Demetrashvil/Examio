import Foundation

struct Chapter: Decodable, Identifiable {
    let id: Int
    let chapterTitle: String
    let chapterText: String
    let briefSummary: String
    let questions: [Question]
}
