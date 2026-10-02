import Chroma
import Observation

@Observable @MainActor
final class SheetState {
  var rows = 100
  var columns = 8
  var firstColumn = 0
  var selected = 0
  var values: [Int: String] = [:]
  let scroll = ScrollViewController()
  func value(_ cell: Int) -> String { values[cell] ?? "\(cell / 100 + 1):\(cell % 100 + 1)" }
  func move(_ delta: Int) {
    selected = min((rows - 1) * 100 + columns - 1, max(0, selected + delta))
    if selected % 100 >= columns { selected = selected / 100 * 100 + columns - 1 }
    firstColumn = min(max(0, columns - 8), max(0, selected % 100 - 7))
    scroll.scrollToRow(selected / 100)
  }
}

@MainActor
struct SpreadsheetDemo: Block {
  let state: SheetState
  var body: some Block {
    VStack(spacing: 12) {
      HStack(spacing: 8) {
        Button("Normal", fontScale: 0.55) {
          state.rows = 100
          state.columns = 8
          state.firstColumn = 0
          state.selected = 0
        }
        Button("10K × 100", fontScale: 0.55) {
          state.rows = 10_000
          state.columns = 100
        }
        Button("Columns ←", fontScale: 0.55) { state.firstColumn = max(0, state.firstColumn - 8) }
        Button("Columns →", fontScale: 0.55) {
          state.firstColumn = min(state.columns - 8, state.firstColumn + 8)
        }
        Button("↑", fontScale: 0.55) { state.move(-100) }
        Button("↓", fontScale: 0.55) { state.move(100) }
        Button("←", fontScale: 0.55) { state.move(-1) }
        Button("→", fontScale: 0.55) { state.move(1) }
      }
      Text("Cell \(state.selected / 100 + 1):\(state.selected % 100 + 1) • 8-column viewport")
        .fontScale(0.6)
      TextEditor(
        "Cell value", fontScale: 0.65, singleLine: true,
        text: { state.value(state.selected) }, onChange: { state.values[state.selected] = $0 })
      ScrollView("Rows", data: 0..<state.rows, rowHeight: 42, controller: state.scroll) { row in
        HStack(spacing: 4) {
          ForEach(state.firstColumn..<min(state.columns, state.firstColumn + 8), id: \.self) {
            column in
            Button(
              state.value(row * 100 + column), fontScale: 0.48,
              style: state.selected == row * 100 + column ? DemoStyle.selectedButton : nil
            ) { state.selected = row * 100 + column }
            .sizing(x: .grow).background(
              state.selected == row * 100 + column ? DemoStyle.accent : DemoStyle.panel)
          }
        }
      }
    }
  }
}
