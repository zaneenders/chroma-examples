import Chroma
import ChromaApp

@main
private struct SpreadsheetDemoApp: NativeApp {
  private let demo = SpreadsheetApplication()
  var title: String { demo.title }
  var windowSize: Size { demo.windowSize }
  var keyBindings: KeyBindings { demo.keyBindings }
  var body: some Block { demo.body }
}
