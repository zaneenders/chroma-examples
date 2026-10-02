import Chroma
import Observation

@Observable @MainActor
final class DemoHelpState {
  var isVisible = false
}

@MainActor
struct DemoShell<Content: Block>: Block {
  let title: String
  let help: DemoHelpState
  let content: Content

  var body: some Block {
    VStack(spacing: 16) {
      HStack(spacing: 10) {
        Text("CHROMA / \(title)").fontScale(0.85)
          .foregroundColor(DemoStyle.accent).navigationIgnored()
        Spacer()
        Button(help.isVisible ? "Hide keys" : "Keys", fontScale: 0.6) {
          help.isVisible.toggle()
        }
      }
      content.sizing(x: .grow, y: .grow)
      if help.isVisible {
        Text(
          "d/f/j/k: move   l: enter / use   s: leave group / board\nEnter: activate   Esc: leave input"
        )
        .fontScale(0.5).foregroundColor(DemoStyle.muted).navigationIgnored()
      }
    }
    .padding(24).background(DemoStyle.background).chromaTheme(DemoStyle.theme)
  }
}
