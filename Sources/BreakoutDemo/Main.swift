import Chroma
import ChromaApp

@main
private struct BreakoutDemoApp: NativeApp {
  private let demo = BreakoutApplication()
  var title: String { demo.title }
  var windowSize: Size { demo.windowSize }
  var keyBindings: KeyBindings { demo.keyBindings }
  var body: some Block { demo.body }
}
