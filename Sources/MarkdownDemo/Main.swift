import Chroma
import ChromaApp
import ChromaMarkdown

@MainActor
public struct MarkdownApplication: App {
  public init() {}
  public var title: String { "Chroma — Markdown" }
  public var windowSize: Size { Size(width: 960, height: 720) }

  public var keyBindings: KeyBindings {
    KeyBindings.modalNavigation.overlay {
      bind(.leftArrow, in: .movement, to: .editing(.moveCaretLeft))
      bind(.leftArrow, modifiers: .shift, in: .movement, to: .editing(.selectCaretLeft))
      bind(.rightArrow, in: .movement, to: .editing(.moveCaretRight))
      bind(.rightArrow, modifiers: .shift, in: .movement, to: .editing(.selectCaretRight))
      bind(.upArrow, in: .movement, to: .editing(.moveCaretUp))
      bind(.upArrow, modifiers: .shift, in: .movement, to: .editing(.selectCaretUp))
      bind(.downArrow, in: .movement, to: .editing(.moveCaretDown))
      bind(.downArrow, modifiers: .shift, in: .movement, to: .editing(.selectCaretDown))
      #if os(macOS)
      bind("c", modifiers: .command, to: .editing(.copy))
      bind("a", modifiers: .command, to: .editing(.selectAll))
      #else
      bind("c", modifiers: .control, to: .editing(.copy))
      bind("a", modifiers: .control, to: .editing(.selectAll))
      #endif
    }
  }

  public var body: some Block {
    ScrollView {
      MarkdownText(Self.sample, scale: 0.8).padding(24).sizing(x: .grow)
    }.sizing(x: .grow, y: .grow).background(ChromaTheme.dark.background)
      .chromaTheme(.dark)
  }

  public static let sample = """
    # Chroma Markdown

    A standalone **Markdown renderer** with `inline code`, driven by the Chroma theme.
    Resize the window to see text wrap.
    Use j/f to move down/up, l to enter the document, and s to leave it.
    Press l again on a block to select characters; use arrows and Shift+arrows.
    Copy with Command+C / Ctrl+C and press Escape to return to block navigation.

    ## Supported blocks

    - Headings and paragraphs
    - **Bold text** and `inline code`
      - Nested list items
    1. Ordered lists
    2. Fenced code and quotes

    > Rendering does not depend on a chat session or a transcript.

    ---

    ```swift
    import ChromaMarkdown

    MarkdownText("# Hello\\n\\nBuilt with **Chroma**.")
    ```

    ## Unicode

    Café, naïve, 日本語, and 👋 remain intact.

    Links, tables and italic markup are not interpreted in this initial renderer.
    """
}

@main
private struct MarkdownDemoApp: NativeApp {
  private let demo = MarkdownApplication()
  var title: String { demo.title }
  var windowSize: Size { demo.windowSize }
  var keyBindings: KeyBindings { demo.keyBindings }
  var body: some Block { demo.body }
}
