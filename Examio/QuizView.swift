import SwiftUI

struct QuizView: View {
    let questions: [Question]
    let onFinish: () -> Void
    
    @State private var shuffledQuestions: [Question] = []
    @State private var currentQuestionIndex = 0
    @State private var selectedAnswer: Int? = nil
    @State private var isAnswerChecked: Bool = false
    @State private var score = 0
    @State private var showResult: Bool = false
    @Environment(\.dismiss) private var dismiss
    
    var currentQuestion: Question {
        shuffledQuestions[currentQuestionIndex]
    }

    var body: some View {
        if shuffledQuestions.isEmpty {
            ProgressView()
                .onAppear {
                    shuffledQuestions = questions.shuffled().map { question in
                        let correctAnswer = question.answers[question.correctAnswer]
                        let shuffledAnswers = question.answers.shuffled()
                        
                        let newCorrectAnswer = shuffledAnswers.firstIndex { answer in
                            answer.text == correctAnswer.text
                        }!
                        
                        return Question(
                            questionText: question.questionText,
                            answers: shuffledAnswers,
                            correctAnswer: newCorrectAnswer,
                            explanation: question.explanation
                        )
                    }
                }
        } else if showResult {
            QuizResultView(
                score: score,
                totalQuestions: shuffledQuestions.count,
                onFinish: {
                    dismiss()
                    onFinish()
                }
            )
        } else {
            HStack {
                ZStack(alignment: .leading) {
                    Capsule()
                        .fill(Color.gray)

                    Capsule()
                        .fill(Color.purple)
                        .frame(
                            width: CGFloat(350) * CGFloat(currentQuestionIndex + 1) / CGFloat(shuffledQuestions.count),
                            height: 10
                        )
                }
                    .frame(width: 350, height: 10)

                    Text("\(Int(Double(currentQuestionIndex + 1) / Double(shuffledQuestions.count) * 100))%")
                }
                
                Spacer()
                
                VStack(spacing: 20) {
                    Text("კითხვა \(currentQuestionIndex + 1) / \(shuffledQuestions.count)")
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundStyle(Color.gray)
                    
                    Text(currentQuestion.questionText)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    
                    
                    ForEach(currentQuestion.answers.indices, id: \.self) { index in
                        Button(currentQuestion.answers[index].text) {
                            selectedAnswer = index
                        }
                        .frame(width: 350)
                        .padding(.horizontal)
                        .padding(.vertical)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(selectedAnswer == index ? Color.purple : Color.gray.opacity(0.1))
                        )
                        .foregroundStyle(selectedAnswer == index ? Color.white : Color.black)
                        .disabled(isAnswerChecked)
                    }
                    
                    Button("პასუხის შემოწმება") {
                        isAnswerChecked = true
                    }
                    .frame(width: 350)
                    .padding(.horizontal)
                    .padding(.vertical)
                    .background(Color.purple)
                    .foregroundStyle(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .disabled(selectedAnswer == nil)
                    
                    if isAnswerChecked {
                        if selectedAnswer == currentQuestion.correctAnswer {
                            Text("სწორია!")
                                .font(.headline)
                                .fontWeight(.medium)
                                .foregroundStyle(.green)
                        } else {
                            Text("არასწორია!")
                                .font(.headline)
                                .fontWeight(.medium)
                                .foregroundStyle(.red)
                        }
                        
                        Text(currentQuestion.explanation)
                            .fontWeight(.semibold)
                            .foregroundStyle(selectedAnswer == currentQuestion.correctAnswer ? Color.green : Color.red)
                    }
                    
                    Button("შემდეგი კითხვა") {
                        if selectedAnswer == currentQuestion.correctAnswer {
                            score += 1
                        }
                        
                        if currentQuestionIndex < shuffledQuestions.count - 1 {
                            currentQuestionIndex += 1
                            selectedAnswer = nil
                            isAnswerChecked = false
                        } else {
                            showResult = true
                        }
                    }
                    .disabled(selectedAnswer == nil)
                }
                
                Spacer()
        }
    }
}
