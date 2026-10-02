import Chroma
import Observation

@Observable @MainActor
final class LifeState {
  var side = 32
  var cells: Set<Int> = []
  var generation = 0
  var running = false
  private let ticker = DemoTicker()
  init() { reset(32) }
  func reset(_ side: Int) {
    stop()
    self.side = side
    generation = 0
    cells = Set((0..<side * side).filter { (($0 &* 1_103_515_245 &+ 12_345) >> 8) % 7 < 2 })
  }
  func step() {
    var neighbors: [Int: Int] = [:]
    for cell in cells {
      let x = cell % side
      let y = cell / side
      for dy in -1...1 {
        for dx in -1...1 where dx != 0 || dy != 0 {
          let nx = x + dx
          let ny = y + dy
          if nx >= 0 && nx < side && ny >= 0 && ny < side {
            neighbors[ny * side + nx, default: 0] += 1
          }
        }
      }
    }
    cells = Set(
      neighbors.compactMap { cell, count in
        count == 3 || (count == 2 && cells.contains(cell)) ? cell : nil
      })
    generation += 1
  }
  func stop() {
    running = false
    ticker.stop()
  }
  func toggle() {
    if running {
      stop()
    } else {
      running = true
      ticker.start(milliseconds: 100) { [weak self] in self?.step() }
    }
  }
}

@MainActor
struct LifeDemo: Block {
  let state: LifeState
  var body: some Block {
    VStack(spacing: 12) {
      HStack(spacing: 8) {
        Button(state.running ? "Pause" : "Run", fontScale: 0.6) { state.toggle() }
        Button("Step", fontScale: 0.6) { state.step() }
        Button("32 × 32", fontScale: 0.6) { state.reset(32) }
        Button("256 × 256", fontScale: 0.6) { state.reset(256) }
        Text("Generation \(state.generation) • \(state.cells.count) alive").fontScale(0.55)
      }
      LifeBoard(state: state).sizing(x: .grow, y: .grow)
    }
  }
}

private struct LifeBoard: PrimitiveBlock {
  let state: LifeState
  var focusRule: FocusRule { .decorative }
  var expandsHorizontally: Bool { true }
  var expandsVertically: Bool { true }
  func sizeThatFits(_ proposal: Size, context: BlockContext) -> Size { proposal }
  @MainActor func draw(into list: inout DrawList, in rect: Rect, context: BlockContext) {
    let cell = min(rect.size.width, rect.size.height) / Float(state.side)
    list.fillRect(rect, color: DemoStyle.panel)
    list.pushClip(rect)
    for id in state.cells.sorted() {
      list.fillRect(
        Rect(
          x: rect.minX + Float(id % state.side) * cell,
          y: rect.minY + Float(id / state.side) * cell, width: max(1, cell - 1),
          height: max(1, cell - 1)),
        color: DemoStyle.accent)
    }
    list.popClip()
  }
}
