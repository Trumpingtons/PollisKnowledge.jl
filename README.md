# PollisKnowledge.jl

Openly licensed texts that [Pollis](https://pollis.org) searches as a collection of its own, the Knowledge Base, so that Ask Pollis can answer from them: books, lecture notes, reports, manuals and other written works. Each text is an artifact of the package, downloaded the first time it is asked for, with its licence. Pollis keeps the passages and the embeddings of a text in its own index, made on the computer with the embedding model chosen there. Pollis's Knowledge Base page (Compose > Knowledge for AI Models > Knowledge Base) switches the texts on and builds the index.

```julia
import PollisKnowledge as PK
PK.catalogue()                                   # the texts
PK.documents("algorithms_for_decision_making")   # downloads the text once, then lists its documents
PK.licence("algorithms_for_decision_making")     # its authors, source and licence
```

## Texts

| Id | Text | Type | Authors | Licence | As kept |
|---|---|---|---|---|---|
| `dive_into_deep_learning` | Dive into Deep Learning, release 1.0.3 | Book | Zhang, Lipton, Li and Smola | CC BY-SA 4.0 | Its Markdown sources, one file a section, without code: the text of the PyTorch tabs kept, cross-references and citations in words, figures as their captions |
| `probabilistic_machine_learning` | Probabilistic Machine Learning: An Introduction, draft of 2025-04-18 | Book | Murphy | CC BY-NC-ND 4.0 | The PDF of its author, unchanged |
| `algorithms_for_optimization` | Algorithms for Optimization, Second Edition, preview | Book | Kochenderfer and Wheeler | CC BY-NC-ND 4.0 | The PDF of its authors, unchanged |
| `algorithms_for_decision_making` | Algorithms for Decision Making | Book | Kochenderfer, Wheeler and Wray | CC BY-NC-ND 4.0 | The PDF of its authors, unchanged |

The algorithms of Algorithms for Optimization and Algorithms for Decision Making are written in Julia. The catalogue, `data/catalogue.toml`, gives each text's page, source and revision. Each artifact holds `LICENCE.md`, with the text's authors, source, what it changes and its licence.

## Licence

The code of the package is under the MIT License. Each text is under its own licence, above.
