struct IconFilename {
	let app: App
	let size: IconSize
	init(app: App, size: IconSize) {
		self.app = app
		self.size = size
	}

	static func allFilenames(for app: App) -> [IconFilename] {
		IconSize.allCases.map { size in
			IconFilename(app: app, size: size)
		}
	}

	var png: String {
		head + body + ".png"
	}

	var mvg: String {
		head + body + ".mvg"
	}

	private var head: String {
		"Icon-\(app.name)-"
	}

	private var body: String {
		switch size.scale {
		case .one:
			return "\(size.pixelWidth)"
		case .two, .three:
			return "\(size.pixelWidth)-\(size.baseWidth)\(size.scale.suffix)"
		}
	}
}
