import Chroma

@MainActor
struct LifeApplication: App {
  let state = LifeState()
  private let help = DemoHelpState()

  var title: String { "Chroma — Life" }
  var windowSize: Size { Size(width: 1120, height: 840) }
  var keyBindings: KeyBindings { demoKeyBindings(shortcutModifier: demoShortcutModifier) }
  var body: some Block {
    DemoShell(title: "Life", help: help, content: LifeDemo(state: state))
  }
}
