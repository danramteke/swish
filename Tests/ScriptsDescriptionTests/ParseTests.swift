import XCTest
import ScriptsDescription
import Yams

final class ParseTest: XCTestCase {

	func testParseJSON() throws {
		let json = """
		{
			"scripts": {
				"clean": "swift package clean",
				"status": "git status -b porcelain",
				"ls": "ls"
			}
		}
		"""

		let description = try JSONDecoder().decode(Scripts.self, from: json.data(using: .utf8)!)

		XCTAssertEqual(description.scripts.count, 3)
		XCTAssertEqual(description.scripts["clean"], "swift package clean")

	}

	func testParseYAML() throws {
		let yml = """
scripts:
  clean: "swift package clean"
  status: "git status -b porcelain"
  ls: ls
"""

		let description = try YAMLDecoder().decode(Scripts.self, from: yml.data(using: .utf8)!)

		XCTAssertEqual(description.scripts.count, 3)
		XCTAssertEqual(description.scripts["clean"], "swift package clean")

	}
}
