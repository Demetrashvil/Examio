import Foundation

enum JSONLoaderError: Error {
    case fileNotFound
}

struct JSONLoader {
    
    func loadLiteraryWorks() throws -> [LiteraryWork] {
        let fileNames = [
            "shushanik",
            "abo",
            "grigol"
        ]
        
        let decoder = JSONDecoder()
        var works: [LiteraryWork] = []
        
        for fileName in fileNames {
            guard let url = Bundle.main.url(
                forResource: fileName,
                withExtension: "json"
            ) else {
                print("File not found:", fileName)
                continue
            }
            
            let data = try Data(contentsOf: url)
            let work = try decoder.decode(LiteraryWork.self, from: data)
            
            works.append(work)
            
            print("Загружен файл: \(fileName), Название произведения: \(work.title)")
        }
        
        return works
    }
}
