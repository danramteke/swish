import Foundation

class DirectoryDateFormatter: DateFormatter {
    override init() {
        super.init()
        self.dateFormat = "YYYY-MM-dd'T'HHmmss"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
