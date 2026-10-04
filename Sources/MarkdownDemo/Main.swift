import Chroma
import ChromaApp
import ChromaMarkdown

@MainActor
public struct MarkdownApplication: App {
  public init() {}
  public var title: String { "Chroma — Markdown" }
  public var windowSize: Size { Size(width: 960, height: 720) }

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
  var body: some Block { demo.body }
}
