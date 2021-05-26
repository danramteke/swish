import Foundation

public protocol Query {
    associatedtype Output
    func execute() -> Result<Output, Error>
}
