import Foundation

public class ShellHelper {

	func execute(text: String) throws -> String {
		print("running text: ", text)
		return "done"
	}
}
