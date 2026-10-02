import Chroma

@MainActor
struct TextEditingApplication: App {
  let state = EditorState()
  private let help = DemoHelpState()

  var title: String { "Chroma — Text" }
  var windowSize: Size { Size(width: 1120, height: 840) }
  var keyBindings: KeyBindings { demoKeyBindings(shortcutModifier: demoShortcutModifier) }
  var body: some Block {
    DemoShell(title: "Text", help: help, content: TextEditingDemo(state: state))
  }
}
