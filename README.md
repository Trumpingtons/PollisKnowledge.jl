# PollisBooks.jl

Open books that [Pollis](https://pollis.org) searches as a collection of its own, PollisBooks, so that Ask Pollis can answer from them. Each book is an artifact of the package, downloaded the first time it is asked for, with its licence. Pollis keeps the passages and the embeddings of a book in its own index, made on the computer with the embedding model chosen there.

```julia
import PollisBooks as PBk
PBk.books()                                       # the catalogue
PBk.documents("algorithms_for_decision_making")   # downloads the book once, then lists its documents
PBk.licence("algorithms_for_decision_making")     # its authors, source and licence
```

## Books

| Id | Book | Authors | Licence | As kept |
|---|---|---|---|---|
| `dive_into_deep_learning` | Dive into Deep Learning, release 1.0.3 | Zhang, Lipton, Li and Smola | CC BY-SA 4.0 | Its Markdown sources, one file a section, without code: the text of the PyTorch tabs kept, cross-references and citations in words, figures as their captions |
| `probabilistic_machine_learning` | Probabilistic Machine Learning: An Introduction, draft of 2025-04-18 | Murphy | CC BY-NC-ND 4.0 | The PDF of its author, unchanged |
| `algorithms_for_optimization` | Algorithms for Optimization, Second Edition, preview | Kochenderfer and Wheeler | CC BY-NC-ND 4.0 | The PDF of its authors, unchanged |
| `algorithms_for_decision_making` | Algorithms for Decision Making | Kochenderfer, Wheeler and Wray | CC BY-NC-ND 4.0 | The PDF of its authors, unchanged |

The algorithms of the two books of Kochenderfer and his co-authors are written in Julia. The catalogue, `data/catalogue.toml`, gives each book's page, source and revision. Each artifact holds `LICENCE.md`, with the book's authors, source, what it changes and its licence.

## Licence

The code of the package is under the MIT License. Each book is under its own licence, above.
