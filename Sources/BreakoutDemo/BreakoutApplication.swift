import Chroma

@MainActor
struct BreakoutApplication: App {
  let state = BreakoutState()
  private let help = DemoHelpState()

  var title: String { "Chroma — Breakout" }
  var windowSize: Size { Size(width: 1120, height: 840) }
  var keyBindings: KeyBindings { demoKeyBindings(shortcutModifier: demoShortcutModifier) }
  var body: some Block {
    DemoShell(title: "Breakout", help: help, content: BreakoutDemo(state: state))
  }
}
