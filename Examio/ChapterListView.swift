import SwiftUI

struct ChapterListView: View {
    let work: LiteraryWork

    var body: some View {
        List(work.chapters) { chapter in
            NavigationLink(destination: ChapterReaderView(chapter: chapter)) {
                VStack(alignment: .leading) {
                    Text(chapter.chapterTitle)
                        .font(.headline)
                        .fontWeight(.medium)
                }
            }
        }
    }
}
