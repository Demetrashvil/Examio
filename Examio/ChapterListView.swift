
import SwiftUI

struct ChapterProgress: Codable {
    var correctAnswers: Int = 0
    var totalQuestions: Int = 0

    var percentage: Double {
        guard totalQuestions > 0 else { return 0 }
        return Double(correctAnswers) / Double(totalQuestions)
    }
}

struct ChapterListView: View {
    let work: LiteraryWork

    @State private var progress: [String: ChapterProgress] = [:]

    private var storageKey: String {
        "chapterProgress_\(work.title)"
    }

    var body: some View {
        List(work.chapters) { chapter in
            let chapterID = String(describing: chapter.id)
            let chapterProgress = progress[chapterID] ?? ChapterProgress()

            NavigationLink {
                ChapterReaderView(chapter: chapter) { correct, total in
                    let newProgress = ChapterProgress(
                        correctAnswers: correct,
                        totalQuestions: total
                    )

                    progress[chapterID] = newProgress
                    saveProgress()
                }
            } label: {
                VStack(alignment: .leading, spacing: 10) {
                    Text(chapter.chapterTitle)
                        .font(.headline)
                        .fontWeight(.medium)

                    HStack {
                        Text(
                            "\(chapterProgress.correctAnswers)/\(chapterProgress.totalQuestions) სწორია"
                        )
                        .font(.caption)
                        .foregroundStyle(.secondary)

                        Spacer()

                        Text("\(Int(chapterProgress.percentage * 100))%")
                            .font(.caption)
                            .fontWeight(.semibold)
                    }

                    GeometryReader { geometry in
                        ZStack(alignment: .leading) {
                            Capsule()
                                .fill(Color.gray.opacity(0.2))

                            Capsule()
                                .fill(Color.purple)
                                .frame(
                                    width: geometry.size.width * chapterProgress.percentage
                                )
                        }
                    }
                    .frame(height: 10)
                }
                .padding(.vertical, 5)
            }
        }
        .navigationTitle(work.title)
        .onAppear {
            loadProgress()
        }
    }

    private func saveProgress() {
        guard let data = try? JSONEncoder().encode(progress) else {
            return
        }

        UserDefaults.standard.set(data, forKey: storageKey)
    }

    private func loadProgress() {
        guard
            let data = UserDefaults.standard.data(forKey: storageKey),
            let savedProgress = try? JSONDecoder().decode(
                [String: ChapterProgress].self,
                from: data
            )
        else {
            return
        }

        progress = savedProgress
    }
}
