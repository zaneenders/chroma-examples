import Chroma

@MainActor
final class DemoTicker {
  private var task: Task<Void, Never>?
  deinit { task?.cancel() }

  func start(milliseconds: Int, action: @escaping @MainActor () -> Void) {
    stop()
    task = Task {
      while !Task.isCancelled {
        do { try await Task.sleep(for: .milliseconds(milliseconds)) } catch { return }
        guard !Task.isCancelled else { return }
        action()
      }
    }
  }

  func stop() {
    task?.cancel()
    task = nil
  }
}
