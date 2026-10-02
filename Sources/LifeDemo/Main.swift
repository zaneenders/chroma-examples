import Chroma
import ChromaApp

@main
private struct LifeDemoApp: NativeApp {
  private let demo = LifeApplication()
  var title: String { demo.title }
  var windowSize: Size { demo.windowSize }
  var keyBindings: KeyBindings { demo.keyBindings }
  var body: some Block { demo.body }
}
