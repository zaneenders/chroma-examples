import Chroma
import ChromaApp

@main
private struct TextEditingDemoApp: NativeApp {
  private let demo = TextEditingApplication()
  var title: String { demo.title }
  var windowSize: Size { demo.windowSize }
  var keyBindings: KeyBindings { demo.keyBindings }
  var body: some Block { demo.body }
}
