import Chroma

@MainActor
public struct ChatApplication: App {
  let state: ChatState
  private let help = DemoHelpState()
  private let shortcutModifier: KeyModifiers

  public init() {
    self.init(state: ChatState(), shortcutModifier: demoShortcutModifier)
  }
  init(state: ChatState, shortcutModifier: KeyModifiers) {
    self.state = state
    self.shortcutModifier = shortcutModifier
  }

  public var title: String { "Chroma — Chat" }
  public var windowSize: Size { Size(width: 1120, height: 840) }
  public var keyBindings: KeyBindings { demoKeyBindings(shortcutModifier: shortcutModifier) }
  public var body: some Block {
    DemoShell(
      title: "Chat", help: help,
      content: ChatDemo(state: state, shortcutModifier: shortcutModifier))
  }
}
