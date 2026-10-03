import Chroma
import ChromaApp

@main
struct StressExample: NativeApp {
  let scene = StressScene()

  var title: String { "Chroma Stress Lab" }
  var windowSize: Size { StressConfiguration.viewport }
  var body: some Block { scene.content }
}
