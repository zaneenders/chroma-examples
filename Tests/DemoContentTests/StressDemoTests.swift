import Chroma
import ChromaTesting
import Testing

@testable import BreakoutDemo
@testable import LifeDemo
@testable import SpreadsheetDemo
@testable import TextEditingDemo

@MainActor
struct StressDemoTests {
  @Test func applicationsRender() throws {
    #expect(try !NavigationTestHost(app: SpreadsheetApplication()).host.render().commands.isEmpty)
    #expect(try !NavigationTestHost(app: BreakoutApplication()).host.render().commands.isEmpty)
    #expect(try !NavigationTestHost(app: TextEditingApplication()).host.render().commands.isEmpty)
    #expect(try !NavigationTestHost(app: LifeApplication()).host.render().commands.isEmpty)
  }

  @Test func sheetKeepsEditsAndRevealsSelection() {
    let sheet = SheetState()
    sheet.rows = 10_000
    sheet.columns = 100
    sheet.values[0] = "edited"
    sheet.move(99)
    #expect(sheet.firstColumn == 92)
    sheet.move(100)
    #expect(sheet.selected == 199)
    #expect(sheet.value(0) == "edited")
  }

  @Test func lifeBlinkerAndDeterministicReset() {
    let life = LifeState()
    let seeded = life.cells
    life.reset(32)
    #expect(life.cells == seeded)
    life.side = 5
    life.cells = [11, 12, 13]
    life.step()
    #expect(life.cells == [7, 12, 17])
    life.step()
    #expect(life.cells == [11, 12, 13])
  }

  @Test func breakoutReplayIsDeterministic() {
    let first = BreakoutState()
    let second = BreakoutState()
    first.reset(100)
    second.reset(100)
    for _ in 0..<120 {
      first.step()
      second.step()
    }
    #expect(first.balls == second.balls)
    #expect(first.bricks == second.bricks)
    first.move(-100)
    #expect(first.paddle == 0.12)
  }

  @Test func lifeTickerReleasesItsOwner() {
    weak var lifeReference: LifeState?
    do {
      let life = LifeState()
      lifeReference = life
      life.toggle()
    }
    #expect(lifeReference == nil)
  }
}
