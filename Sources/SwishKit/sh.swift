import MPath
import Logging

/**

Provides a global Shell Runner so that `cmd` and `sh` are easily usable from your code.

These global `cmd` and `sh` functions delegate to the global SharedShellRunner. To customize the behavior, instantiate your own `ShellRunner`, or set the settings on the `SharedShellRunner`
*/

public let SharedShellRunner = ShellRunner()

public func cmd(_ text: String, env: [String: String]? = nil) -> ShellCommand {
	SharedShellRunner.cmd(text, env: env)
}

public func sh(_ text: String, env: [String: String]? = nil) throws {
	try SharedShellRunner.sh(text, env: env)
}

public func cmd<T: ShellOutputInitable>(_ text: String, as type: T.Type, env: [String: String]? = nil) -> ConcreteShellQuery<T> {
	SharedShellRunner.cmd(text, as: type, env: env)
}

public func sh<T: ShellOutputInitable>(_ text: String, as type: T.Type, env: [String: String]? = nil) throws -> T {
	try SharedShellRunner.sh(text, as: type, env: env)
}

public func sh<T: ShellOutputInitable>(_ text: String, env: [String: String]? = nil) throws -> T {
	try SharedShellRunner.sh(text, env: env)
}

public func cmd(_ text: String, _ interpretation: BooleanStringInterpretation, env: [String: String]? = nil) -> ConcreteBooleanShellQuery {
	SharedShellRunner.cmd(text, interpretation, env: env)
}

public func sh(_ text: String, _ interpretation: BooleanStringInterpretation, env: [String: String]? = nil) throws -> Bool {
	try SharedShellRunner.sh(text, interpretation, env: env)
}

public func resolve<T: Target>(_ targetID: T, force: Bool) throws {
	try SharedShellRunner.resolve(targetID, force: force)
}
