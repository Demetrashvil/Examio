import SwiftUI

struct ChapterReaderView: View {
    let chapter: Chapter
    let onProgressUpdate: (Int, Int) -> Void

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack(alignment: .leading, spacing: 20) {
                Text(chapter.chapterTitle)
                    .font(.title2)
                    .fontWeight(.medium)
                    .padding(.horizontal, 16)

                Text(chapter.chapterText)
                    .font(.system(.title3, design: .serif))
                    .lineSpacing(8)
                    .foregroundColor(.primary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 16)

                Text("შინაარსი")
                    .font(.title2)
                    .fontWeight(.medium)
                    .padding(.horizontal, 16)

                Text(chapter.briefSummary)
                    .font(.system(.title3, design: .serif))
                    .lineSpacing(8)
                    .foregroundColor(.primary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 16)

                NavigationLink {
                    QuizView(
                        questions: chapter.questions,
                        onFinish: { correct, total in
                            onProgressUpdate(correct, total)
                            dismiss()
                        }
                    )
                } label: {
                    Text("ტესტის დაწყება")
                        .frame(width: 250, height: 45)
                        .background(Color.purple)
                        .foregroundStyle(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal)
                        .padding(.vertical)
                }
            }
        }
    }
}
