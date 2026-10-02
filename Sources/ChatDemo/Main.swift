import Chroma
import ChromaApp

@main
private struct ChatDemoApp: NativeApp {
  private let demo = ChatApplication()
  var title: String { demo.title }
  var windowSize: Size { demo.windowSize }
  var keyBindings: KeyBindings { demo.keyBindings }
  var body: some Block { demo.body }
}
