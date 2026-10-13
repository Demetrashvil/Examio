import SwiftUI

struct LiteratureView: View {
    @State private var works: [LiteraryWork] = []
    @State private var errorMessage: String?

    var body: some View {
        NavigationStack {
            Group {
                if let errorMessage {
                    ContentUnavailableView(
                        "შეცდომა",
                        systemImage: "exclamationmark.triangle",
                        description: Text(errorMessage)
                    )
                } else if works.isEmpty {
                    ProgressView("იტვირთება...")
                } else {
                    List(works) { work in
                        NavigationLink(destination: ChapterListView(work: work)) {
                            VStack(alignment: .leading, spacing: 5) {
                                Text(work.title)
                                    .font(.title3)
                                    .fontWeight(.semibold)

                                Text(work.author)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                }
            }
            .navigationTitle("ლიტერატურა")
        }
        .task {
            do {
                let loader = JSONLoader()
                works = try loader.loadLiteraryWorks()
            } catch {
                errorMessage = error.localizedDescription
                print("Error loading literary works: \(error)")
            }
        }
    }
}

