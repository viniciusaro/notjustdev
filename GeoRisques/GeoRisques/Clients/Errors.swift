struct UnimplementedError: Error {
    let message: String
    
    init(message: String = "", function: String = #function) {
        self.message = message + " (function: \(function))"
    }
}
