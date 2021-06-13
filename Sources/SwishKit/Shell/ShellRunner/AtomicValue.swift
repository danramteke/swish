import Foundation

// see:  https://www.donnywals.com/why-your-atomic-property-wrapper-doesnt-work-for-collection-types/

public class AtomicValue<Value> {

	private var _value: Value
	private let queue: DispatchQueue

	public init(initial: Value, label maybeLabel: String? = nil) {
		self._value = initial
		let queueLabel = maybeLabel ?? String(describing: Self.self)
		self.queue = DispatchQueue(
			label: "\(queueLabel).\(UUID().uuidString)",
			qos: .utility,
			attributes: .concurrent,
			autoreleaseFrequency: .inherit,
			target: .global())
	}

	public var value: Value {
		get {
			queue.sync { _value }
		}
		set {
			queue.async(flags: .barrier) { [weak self] in
				self?._value = newValue
			}
		}
	}
}

extension AtomicValue where Value == Int {
	public func claim() -> Int { //increment, after returning currentvalue
		queue.sync(flags: .barrier) {
			let current = _value
			let next = current + 1
			_value = next
			return current
		}
	}
}
