public protocol Command {
    func execute() -> Result<Void, Error>
}

public protocol DependantCommand: Command {
    var dependsOn: [Command] { get }
}

public protocol ConditionalCommand: Command {
    var shouldRun: Bool { get }
}

public protocol ConditionalDepedantCommand: DependantCommand, ConditionalCommand {}
