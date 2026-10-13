import SwiftUI

struct SubjectView: View {
    var body: some View {
        VStack(spacing: 16) {
            NavigationLink(destination: Text("გრამატიკა")) {
                HStack {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("გრამატიკა")
                            .font(.title3)
                            .fontWeight(.semibold)
                        
                        Text("შეისწავლეთ ქართული ენის წესები.")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    
                    Spacer()
                    
                    Image(systemName: "text.book.closed")
                        .font(.title2)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.blue.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 16))
            }
            .buttonStyle(.plain)
            
            NavigationLink(destination: LiteratureView()) {
                HStack {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("ლიტერატურა")
                            .font(.title3)
                            .fontWeight(.semibold)
                        
                        Text("შეისწავლეთ ნაწარმოებები და მათი თავები.")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    
                    Spacer()
                    
                    Image(systemName: "books.vertical")
                        .font(.title2)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.green.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 16))
            }
            .buttonStyle(.plain)
            
            Spacer()
        }
        .padding()
        .navigationTitle("ქართული ენა")
        .navigationBarTitleDisplayMode(.large)
    }
}
