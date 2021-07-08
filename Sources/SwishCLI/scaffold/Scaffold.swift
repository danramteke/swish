import MPath
struct Scaffold {
  func scaffold(at path: Path, manifestPath: Path) throws {


    try (path + "src").createDirectories()

    try Scaffold.package.write(to: path + "Package.swift")
    try Scaffold.swishDescription.write(to: path + "src/SwishDescription.swift")
    try Scaffold.main.write(to: path + "src/main.swift")

    let manifestData = try manifestPath.read()
    try manifestData.write(to: path + "src/Swish.swift")
  }
}
