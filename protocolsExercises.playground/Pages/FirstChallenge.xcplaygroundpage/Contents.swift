import Foundation

protocol TabularDataSource {
    var numberOfRows: Int { get }
    var numberOfColumns: Int { get }

    func label(forColumn column: Int) -> String
    func itemFor(row: Int, column: Int) -> String
}

func printTable(_ dataSource: TabularDataSource & CustomStringConvertible) {
    print(dataSource)
    var headerRow = "|"
    var columnWidths = [Int]()

    for columnIndex in 0..<dataSource.numberOfColumns {
        let columnLabel = dataSource.label(forColumn: columnIndex)
        let columnHeader = " \(columnLabel) |"
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
            let paddingNeeded = columnWidths[rowColumnIndex] - item.count
            let padding = repeatElement(" ", count: paddingNeeded).joined(separator: "")

            output += " \(padding)\(item) |"
        }

        // Done - print it!
        print(output)
    }
}

struct Person {
    let name: String
    let age: Int
    let yearsOfExperience: Int
}

struct Department: TabularDataSource, CustomStringConvertible {
    let name: String
    var people: [Person] = []

    init(name: String) {
        self.name = name
    }

    mutating func add(_ person: Person) {
        people.append(person)
    }

    var numberOfRows: Int { people.count }

    var numberOfColumns: Int { 3 }

    func label(forColumn column: Int) -> String {
        let label: String

        switch column {
        case 0: label = "Employee name"
        case 1: label = "Age"
        case 2: label = "Years of experience"
        default: fatalError("Invalid column!")
        }

        return label
    }

    func itemFor(row: Int, column: Int) -> String {
        let person = people[row]

        let item: String
        switch column {
        case 0: item = person.name
        case 1: item = String(person.age)
        case 2: item = String(person.yearsOfExperience)
        default: fatalError("Invalid column!")
        }

        return item
    }

    var description: String { "Department: \(name)" }
}

var department = Department(name: "Engineering")
department.add(Person(name: "Eva", age: 30, yearsOfExperience: 6))
department.add(Person(name: "Saleh", age: 40, yearsOfExperience: 18))
department.add(Person(name: "Amit", age: 50, yearsOfExperience: 20))

printTable(department)
