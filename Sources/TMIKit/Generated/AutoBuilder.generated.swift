// Generated using Sourcery 0.8.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// swiftlint:disable file_length

class MessageBuilder {

    private var raw: String = 
""

    func getRaw() -> String {
        return raw
    }

    @discardableResult
    func setRaw(_ value: String) -> Self {
        self.raw = value
        return self
    }

    private var tags: [String: String] = 
[:]

    func getTags() -> [String: String] {
        return tags
    }

    @discardableResult
    func setTags(_ value: [String: String]) -> Self {
        self.tags = value
        return self
    }

    private var prefix: String? = 
nil

    func getPrefix() -> String? {
        return prefix
    }

    @discardableResult
    func setPrefix(_ value: String?) -> Self {
        self.prefix = value
        return self
    }

    private var command: String? = 
nil

    func getCommand() -> String? {
        return command
    }

    @discardableResult
    func setCommand(_ value: String?) -> Self {
        self.command = value
        return self
    }

    private var parameters: [String] = 
[]

    func getParameters() -> [String] {
        return parameters
    }

    @discardableResult
    func setParameters(_ value: [String]) -> Self {
        self.parameters = value
        return self
    }


    func build() -> Message {
        return Message(raw: raw, tags: tags, prefix: prefix, command: command, parameters: parameters)
    }

}
