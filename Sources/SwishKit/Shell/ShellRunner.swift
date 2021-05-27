import Foundation

public class ShellRunner {

	func execute(runnable: ShellRunnable) throws -> String {
		try self.execute(text: runnable.text)
	}

	func execute(text: String) throws -> String {
		print("running text: ", text)
		return "done"
	}
}
