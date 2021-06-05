import MPath
import ArgumentParser

extension Path: ExpressibleByArgument {

    public init(argument: String) {
        self.init(argument)
    }
}
