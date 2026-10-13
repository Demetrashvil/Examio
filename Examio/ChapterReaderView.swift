import SwiftUI

struct ChapterReaderView: View {
    let chapter: Chapter

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
                    .fontWidth(.standard)
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 16)
                
                Spacer()
                
                Text("შინაარსი")
                    .font(.title2)
                    .fontWeight(.medium)
                    .padding(.horizontal, 16)
                
                Text(chapter.briefSummary)
                    .font(.system(.title3, design: .serif))
                    .lineSpacing(8)
                    .fontWidth(.standard)
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 16)

                NavigationLink(
                    destination: QuizView(
                        questions: chapter.questions,
                        onFinish: {
                            dismiss()
                        }
                    )
                ) {
                    Text("ტესტის დაწყება")
                        .frame(width: 250, height: 45)
                        .background(Color.purple)
                        .foregroundStyle(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .frame(maxWidth: .infinity)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                        .padding(.vertical)
                }
            }
        }
    }
}
