struct Question: Decodable {
    let questionText: String
    let answers: [Answer]
    let correctAnswer: Int
    let explanation: String
}
