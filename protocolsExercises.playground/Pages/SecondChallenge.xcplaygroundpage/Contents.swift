import Foundation

protocol TabularDataSource {
    var numberOfRows: Int { get }
    var numberOfColumns: Int { get }

    func label(forColumn column: Int) -> String
    func itemFor(row: Int, column: Int) -> String
}

/// Add here your new type that conforms to ``TabularDataSource``

func printTable(_ dataSource: TabularDataSource & CustomStringConvertible) {
    print(dataSource)
    var headerRow = "|"
    var columnWidths = [Int]()

    for rowIndex in 0 ..< dataSource.numberOfColumns {
            let columnLabel = dataSource.label(forColumn: rowIndex)
            columnWidths.append(columnLabel.count)
            for columnIndex in 0 ..< dataSource.numberOfRows {
                let item = dataSource.itemFor(row: columnIndex, column: rowIndex)
                if columnWidths[rowIndex] < item.count {
                    columnWidths[rowIndex] = item.count
                }
            }
        }
    
    for columnIndex in 0..<dataSource.numberOfColumns {
        let columnLabel = dataSource.label(forColumn: columnIndex)
        let paddingNeeded = columnWidths[columnIndex] - columnLabel.count
        let padding = repeatElement(" ", count: paddingNeeded).joined()
        let columnHeader = " \(padding)\(columnLabel) |"
        headerRow += columnHeader
        columnWidths.append(columnLabel.count)
    }

    print(headerRow)

    for rowIndex in 0..<dataSource.numberOfRows {
        // Start the output string
        var output = "|"

        // Append each item in this row to the string
        for rowColumnIndex in 0..<dataSource.numberOfColumns {
            let item = dataSource.itemFor(row: rowIndex, column: rowColumnIndex)
            var paddingNeeded = columnWidths[rowColumnIndex] - item.count
            if paddingNeeded < 0 { paddingNeeded = 0 }
            let padding = repeatElement(" ", count: paddingNeeded).joined(separator: "")

            output += " \(padding)\(item) |"
        }

        // Done - print it!
        print(output)
    }
}

struct Book {
    let title: String
    let author: String
    let averageReview: Double
}

struct BookCollection: TabularDataSource, CustomStringConvertible {
    let name: String
    var books = [Book]()
    
    init(name: String) {
        self.name = name
    }

    mutating func add(_ book: Book) {
            books.append(book)
    }

    var numberOfRows: Int {books.count }

    var numberOfColumns: Int { 3 }

    func label(forColumn column: Int) -> String {
        let label: String

        switch column {
        case 0: label = "Title"
        case 1: label = "Author"
        case 2: label = "Average Rating"
        default: fatalError("Invalid column!")
        }

        return label
    }

    func itemFor(row: Int, column: Int) -> String {
        let book = books[row]

        let item: String
        switch column {
        case 0: item = book.title
        case 1: item = book.author
        case 2: item = String(book.averageReview)
        default: fatalError("Invalid column!")
        }

        return item
    }

    var description: String { "Book Collection: \(name)" }
}

var bookCollection = BookCollection(name: "The Maze Runner")

bookCollection.add(Book(title: "Correr o Morir", author: "James Dashner", averageReview: 9.6))
bookCollection.add(Book(title: "Prueba de Fuego", author: "James Dashner", averageReview: 8.4))
bookCollection.add(Book(title: "La Cura Mortal", author: "James Dashner", averageReview: 8.9))
bookCollection.add(Book(title: "Código C.R.U.E.L.", author: "James Dashner", averageReview: 9.6))
bookCollection.add(Book(title: "El Palacio de los Cranks", author: "James Dashner", averageReview: 7.4))

printTable(bookCollection)

