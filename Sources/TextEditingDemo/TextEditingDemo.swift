import Chroma
import Observation

@Observable @MainActor
final class EditorState {
  var text =
    "Edit, select, copy and paste here.\nCombining: e\u{301} a\u{308}\nIME: 日本語 中文 한국어\nEmoji: 👩🏽‍💻 🏳️‍🌈\nTabs:\tone\ttwo"
  var scale: Float = 0.65
  func loadLines(_ count: Int) {
    text = (0..<count).map { "Line \($0): The quick brown fox jumps over the lazy dog." }.joined(
      separator: "\n")
  }
}

@MainActor
struct TextEditingDemo: Block {
  let state: EditorState
  var body: some Block {
    VStack(spacing: 12) {
      HStack(spacing: 8) {
        Button("100 lines", fontScale: 0.55) { state.loadLines(100) }
        Button("10K lines", fontScale: 0.55) { state.loadLines(10_000) }
        Button("Unbroken 100K", fontScale: 0.55) {
          state.text = String(repeating: "abcdef", count: 16_667)
        }
        Button("Unicode", fontScale: 0.55) { state.text = EditorState().text }
        Button("Scale", fontScale: 0.55) { state.scale = state.scale == 0.65 ? 1 : 0.65 }
      }
      Text(
        "\(state.text.count) characters • resize to rewrap • missing glyphs expose atlas limitations"
      ).fontScale(0.5)
      TextEditor(
        "Document", fontScale: state.scale, lineLimits: 5...30,
        text: { state.text }, onChange: { state.text = $0 }
      ).sizing(x: .grow, y: .grow)
      Text(state.text).fontScale(0.5).wrapping().selectable().sizing(y: .fixed(90))
    }
  }
}
