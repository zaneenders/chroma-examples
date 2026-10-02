import Chroma
import ChromaApp

@main
private struct FallingBlocksDemoApp: NativeApp {
  private let demo = FallingBlocksApplication()
  var title: String { demo.title }
  var windowSize: Size { demo.windowSize }
  var keyBindings: KeyBindings { demo.keyBindings }
  var body: some Block { demo.body }
}
