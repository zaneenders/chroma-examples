import Chroma
import ChromaTesting
import MarkdownDemo
import Testing

@MainActor
struct MarkdownDemoTests {
  @Test func rendersAtWideAndNarrowWindowSizes() {
    for width: Float in [960, 320] {
      let host = HeadlessHost(size: Size(width: width, height: 720))
      host.content = MarkdownApplication().body
      #expect(!host.render().commands.isEmpty)
    }
  }
}
