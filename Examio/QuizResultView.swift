import SwiftUI

struct QuizResultView: View {
    let score: Int
    let totalQuestions: Int
    let onFinish: () -> Void

    var body: some View {
        VStack(spacing: 20) {
            Text("ტესტი დასრულებულია!")
                .font(.title)
                .fontWeight(.semibold)

            Text("\(score) / \(totalQuestions)")
                .font(.title2)
                .fontWeight(.medium)
                .foregroundStyle(Color.gray)

            Text("სწორი პასუხები: \(score)")
                .font(.headline)

            Text("არასწორი პასუხები: \(totalQuestions - score)")
                .font(.headline)

            Button("თავებთან დაბრუნება") {
                onFinish()
            }
            .frame(width: 350)
            .padding(.horizontal)
            .padding(.vertical)
            .background(Color.purple)
            .foregroundStyle(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
    }
}
