import Chroma
import Observation

struct BreakoutBall: Equatable {
  var x: Float = 0.5
  var y: Float = 0.7
  var vx: Float = 0.3
  var vy: Float = -0.45
}

@Observable @MainActor
final class BreakoutState {
  var balls = [BreakoutBall()]
  var bricks = Set(0..<60)
  var paddle: Float = 0.5
  var running = false
  var score = 0
  var hz = 60
  private let ticker = DemoTicker()
  func reset(_ count: Int) {
    stop()
    score = 0
    bricks = Set(0..<60)
    paddle = 0.5
    balls = (0..<count).map {
      BreakoutBall(x: Float($0 % 10 + 1) / 12, vx: Float($0 % 5 + 1) * 0.1)
    }
  }
  func step() {
    let dt = 1 / Float(hz)
    for i in balls.indices {
      balls[i].x += balls[i].vx * dt
      balls[i].y += balls[i].vy * dt
      if balls[i].x < 0.01 || balls[i].x > 0.99 {
        balls[i].x = min(0.99, max(0.01, balls[i].x))
        balls[i].vx *= -1
      }
      if balls[i].y < 0.01 {
        balls[i].y = 0.01
        balls[i].vy = abs(balls[i].vy)
      }
      if balls[i].vy > 0 && balls[i].y >= 0.88 && balls[i].y <= 0.91
        && abs(balls[i].x - paddle) < 0.12
      {
        balls[i].vy = -abs(balls[i].vy)
      }
      if balls[i].y > 1 {
        balls[i].y = 0.7
        balls[i].vy = -0.45
      }
      let column = min(9, max(0, Int(balls[i].x * 10)))
      let row = Int((balls[i].y - 0.08) / 0.04)
      if balls[i].y >= 0.08 && row >= 0 && row < 6 && bricks.remove(row * 10 + column) != nil {
        balls[i].vy *= -1
        score += 1
      }
    }
    if bricks.isEmpty { stop() }
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
      ticker.start(milliseconds: max(1, 1_000 / hz)) { [weak self] in self?.step() }
    }
  }
  func move(_ amount: Float) { paddle = min(0.88, max(0.12, paddle + amount)) }
}

@MainActor
struct BreakoutDemo: Block {
  let state: BreakoutState
  var body: some Block {
    VStack(spacing: 12) {
      HStack(spacing: 8) {
        Button(state.running ? "Pause" : "Play", fontScale: 0.6) { state.toggle() }
        Button("1 ball", fontScale: 0.6) { state.reset(1) }
        Button("100 balls", fontScale: 0.6) { state.reset(100) }
        Button("60 / 120 Hz", fontScale: 0.6) {
          state.stop()
          state.hz = state.hz == 60 ? 120 : 60
        }
        Button("Left", fontScale: 0.6) { state.move(-0.08) }
        Button("Right", fontScale: 0.6) { state.move(0.08) }
        Text("Score \(state.score) • \(state.hz) Hz • d/k move, Space pause").fontScale(0.5)
      }
      BreakoutBoard(state: state)
        .keyBindings {
          bind("d", in: .movement, to: .application("breakout.left"))
          bind("k", in: .movement, to: .application("breakout.right"))
          bind(.space, in: .movement, to: .application("breakout.pause"))
        }
        .onCommand(.application("breakout.left")) {
          state.move(-0.05)
          return .handled
        }
        .onCommand(.application("breakout.right")) {
          state.move(0.05)
          return .handled
        }
        .onCommand(.application("breakout.pause")) {
          state.toggle()
          return .handled
        }
        .onCommand(.action(.cancel)) {
          state.stop()
          return .handled
        }
    }
  }
}

private struct BreakoutBoard: PrimitiveBlock {
  let state: BreakoutState
  var focusRule: FocusRule { .control }
  var expandsHorizontally: Bool { true }
  var expandsVertically: Bool { true }
  func sizeThatFits(_ proposal: Size, context: BlockContext) -> Size { proposal }
  @MainActor func draw(into list: inout DrawList, in rect: Rect, context: BlockContext) {
    _ = context.buttonState(in: rect) { state.toggle() }
    list.fillRect(rect, color: DemoStyle.panel)
    list.pushClip(rect)
    for brick in state.bricks.sorted() {
      list.fillRoundedRect(
        Rect(
          x: rect.minX + Float(brick % 10) * rect.size.width / 10 + 2,
          y: rect.minY + (0.08 + Float(brick / 10) * 0.04) * rect.size.height,
          width: max(0, rect.size.width / 10 - 4), height: max(0, rect.size.height * 0.04 - 3)),
        radius: 3,
        color: DemoStyle.accent)
    }
    list.fillRect(
      Rect(
        x: rect.minX + (state.paddle - 0.12) * rect.size.width,
        y: rect.minY + rect.size.height * 0.9,
        width: rect.size.width * 0.24, height: 8), color: .white)
    for ball in state.balls {
      list.fillRoundedRect(
        Rect(
          x: rect.minX + ball.x * rect.size.width - 4, y: rect.minY + ball.y * rect.size.height - 4,
          width: 8, height: 8), radius: 4, color: .white)
    }
    list.popClip()
  }
}
