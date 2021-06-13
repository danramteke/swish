import MPath
import Logging

/**

Provides a global Shell Runner so that `cmd` and `sh` are easily usable from your code.

These global `cmd` and `sh` functions delegate to the global default SwishContext. To customize the behavior, instantiate your own `SwishContext`.
*/

extension SwishContext {
  public static let `default` = SwishContext()
}

public func cmd(label: String? = nil, _ text: String, env: [String: String]? = nil) -> ShellCommand {
	SwishContext.default.cmd(label: label, text, env: env)
}

public func sh(label: String? = nil, _ text: String, env: [String: String]? = nil) throws {
	try SwishContext.default.sh(label: label, text, env: env)
}

public func cmd<T: ShellOutputInitable>(label: String? = nil, _ text: String, as type: T.Type, env: [String: String]? = nil) -> ConcreteShellQuery<T> {
	SwishContext.default.cmd(label: label, text, as: type, env: env)
}

public func sh<T: ShellOutputInitable>(label: String? = nil, _ text: String, as type: T.Type, env: [String: String]? = nil) throws -> T {
	try SwishContext.default.sh(label: label, text, as: type, env: env)
}

public func sh<T: ShellOutputInitable>(label: String? = nil, _ text: String, env: [String: String]? = nil) throws -> T {
	try SwishContext.default.sh(label: label, text, env: env)
}

public func cmd(label: String? = nil, _ text: String, _ interpretation: BooleanStringInterpretation, env: [String: String]? = nil) -> ConcreteBooleanShellQuery {
	SwishContext.default.cmd(label: label, text, interpretation, env: env)
}

public func sh(label: String? = nil, _ text: String, _ interpretation: BooleanStringInterpretation, env: [String: String]? = nil) throws -> Bool {
	try SwishContext.default.sh(label: label, text, interpretation, env: env)
}

public func resolve<T: Target>(_ targetID: T) throws {
	try SwishContext.default.resolve(targetID)
}
