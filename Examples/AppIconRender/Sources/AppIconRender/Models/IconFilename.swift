struct IconFilename {
  let app: App
  let size: IconSize
  init(app: App, size: IconSize) {
    self.app = app
    self.size = size
  }

  var png: String {
    head + body + ".png"
  }

  private var head: String {
    "Icon-\(app.filename)-"
  }

  private var body: String {
    switch size.data.scale {
    case .one:
      return "\(size.data.pixelWidth)"
    case .two, .three:
      return "\(size.data.pixelWidth)-\(size.data.baseWidth)\(size.data.scale.suffix)"
    }
  }
}