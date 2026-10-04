import Chroma
import ChromaTesting
import MarkdownDemo
import Testing

@MainActor
struct MarkdownDemoTests {
  @Test func keyboardMovesBetweenDocumentBlocks() throws {
    let ui = try NavigationTestHost(app: MarkdownApplication())
    ui.press("j", "l")
    let first = ui.host.render().commands
    ui.press("j")
    let second = ui.host.render().commands
    #expect(first != second)
    ui.press("f")
    #expect(ui.host.render().commands == first)
  }

  @Test func entersCharacterSelectionAndExtendsItWithShiftArrow() throws {
    let ui = try NavigationTestHost(app: MarkdownApplication())
    ui.press("j", "l", "l")
    let caret = ui.host.render().commands
    ui.press(KeyboardInput(chord: KeyChord(.rightArrow, modifiers: .shift)))
    #expect(ui.host.render().commands != caret)
    ui.press(.escape)
    ui.press("j")
    #expect(ui.host.render().commands != caret)
  }

  @Test func rendersAtWideAndNarrowWindowSizes() {
    for width: Float in [960, 320] {
      let host = HeadlessHost(size: Size(width: width, height: 720))
      host.content = MarkdownApplication().body
      #expect(!host.render().commands.isEmpty)
    }
  }
}
