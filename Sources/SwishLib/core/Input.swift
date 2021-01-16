import Foundation


public class Input<Value>: InputConvertible {
  public var value: Value?

  public init() {
    self.value = nil
  }

  public init(_ value: Value) {
    self.value = value
  }

  var asInput: Input<Value> {
    self
  }
}

protocol InputConvertible {
  associatedtype Value
  var asInput: Input<Value> { get }
}

//extension Output: InputConvertible {
//  var asInput: Input<Value> {
//    Input(self.value)
//  }
//}

extension String: InputConvertible {
  var asInput: Input<String> { .init(self) }
}

extension Path: InputConvertible {
  var asInput: Input<Path> { .init(self) }
}



