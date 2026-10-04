# Chroma Examples

Play a falling-blocks game.

```sh
swift run FallingBlocksDemo
```

Explore locally streamed conversations.

```sh
swift run ChatDemo
```

Display a Mandelbrot image.

```sh
swift run ImageDemo
```

Edit a spreadsheet with virtualized rows and a paged eight-column viewport.

```sh
swift run SpreadsheetDemo
```

Play Breakout with one or 100 balls, keyboard controls, and a 60 or 120 Hz simulation.

```sh
swift run BreakoutDemo
```

Edit Unicode text and large documents with selection and clipboard support.

```sh
swift run TextEditingDemo
```

Step, run, or pause deterministic 32×32 or 256×256 Game of Life grids.

```sh
swift run LifeDemo
```


Stress three virtualized 100,000-row panes with deeply nested controls. Scroll each
pane and click **Update all panes** to exercise state invalidation.

```sh
swift run -c release StressExample
```

The scene is adapted from Chroma’s [headless stress benchmark](https://github.com/zaneenders/chroma/tree/838b601/Benchmarks#stress-lab-benchmark-and-native-example)
and included here so all examples build using the remote Chroma dependency.

## Testing

```sh
swift test
```

## Markdown

Render headings, lists, quotes, code and bold text with the optional
`ChromaMarkdown` library. Resize the window to exercise wrapping.

```sh
swift run MarkdownDemo
```

The examples currently use the sibling `../chroma` checkout because
`ChromaMarkdown` is not available at the previously pinned remote revision.
Set `CHROMA_LOCAL_PATH` to use a different local checkout.
