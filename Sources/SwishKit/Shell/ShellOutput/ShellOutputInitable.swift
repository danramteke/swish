import Foundation
import MPath

public protocol ShellOutputInitable {
	init(shellOutput: String) throws
}