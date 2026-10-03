import Chroma

@MainActor
public struct FallingBlocksApplication: App {
  let state: FallingBlocksState
  private let help = DemoHelpState()

  public init() { self.init(state: FallingBlocksState()) }
  init(state: FallingBlocksState) {
    self.state = state
    state.focus.focus()
  }

  public var title: String { "Chroma — Falling Blocks" }
  public var windowSize: Size { Size(width: 1120, height: 840) }
  public var keyBindings: KeyBindings { demoKeyBindings(shortcutModifier: demoShortcutModifier) }
  public var body: some Block {
    DemoShell(title: "Falling Blocks", help: help, content: FallingBlocksDemo(state: state))
  }
}
