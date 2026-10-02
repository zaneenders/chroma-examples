import Chroma

@MainActor
struct SpreadsheetApplication: App {
  let state = SheetState()
  private let help = DemoHelpState()

  var title: String { "Chroma — Spreadsheet" }
  var windowSize: Size { Size(width: 1120, height: 840) }
  var keyBindings: KeyBindings { demoKeyBindings(shortcutModifier: demoShortcutModifier) }
  var body: some Block {
    DemoShell(title: "Spreadsheet", help: help, content: SpreadsheetDemo(state: state))
  }
}
