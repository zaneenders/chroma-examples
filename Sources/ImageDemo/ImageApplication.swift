import Chroma

@MainActor
public struct ImageApplication: App {
  private let help = DemoHelpState()

  public init() {}

  public var title: String { "Chroma — Image" }
  public var windowSize: Size { Size(width: 1120, height: 840) }
  public var keyBindings: KeyBindings { demoKeyBindings(shortcutModifier: demoShortcutModifier) }
  public var body: some Block {
    DemoShell(title: "Image", help: help, content: ImageDemo())
  }
}
