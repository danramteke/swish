public enum Behavior {
	case isEmpty
	case isNotEmpty
	case equals(String)
	case custom((String)->Bool)
}
