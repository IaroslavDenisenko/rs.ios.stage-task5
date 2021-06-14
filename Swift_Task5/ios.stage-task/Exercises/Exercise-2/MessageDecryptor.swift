import UIKit

class MessageDecryptor: NSObject {
    
    func decryptMessage(_ message: String) -> String {
        var result = message
        let pat = "\\d*\\[[a-z]*\\]"
        let regex = NSRegularExpression(pat)
        let range = NSRange(location: 0, length: message.utf16.count)
        let matches = regex.matches(in: message, options: [], range: range)
        if matches.isEmpty { return result }
        for match in matches {
            if let matchRange = Range(match.range, in: message) {
                let encodingMessage = message[matchRange]
                let startIndex = encodingMessage.startIndex
                let endIndex = encodingMessage.endIndex
                var currentIndex = startIndex
                var counter = ""
                for i in 0..<encodingMessage.count {
                    currentIndex = encodingMessage.index(startIndex, offsetBy: i)
                    let symbol = String(encodingMessage[currentIndex])
                    if Int(symbol) != nil {
                        counter += symbol
                    } else {
                        break
                    }
                }
                let startWordIndex = encodingMessage.index(currentIndex, offsetBy: 1)
                let endWordIndex = encodingMessage.index(before: endIndex)
                let wordRange = startWordIndex..<endWordIndex
                let word = String(encodingMessage[wordRange])
                
                result = regex.stringByReplacingMatches(in: message, options: [], range: match.range, withTemplate: String(repeating: word, count: Int(counter) ?? 1))
            }
        }
        
        return decryptMessage(result)
    }
}

extension NSRegularExpression {
    convenience init(_ pattern: String) {
        do {
            try self.init(pattern: pattern)
        } catch {
            preconditionFailure("Illegal regular expression: \(pattern).")
        }
    }
}
