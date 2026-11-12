# PollisKnowledge.jl

Openly licensed texts that [Pollis](https://pollis.org) searches as a collection of its own, the Knowledge Base, so that Ask Pollis can answer from them: books, lecture notes, reports, manuals and other written works. Each text is an artifact of the package, downloaded the first time it is asked for, with its licence. Pollis keeps the passages and the embeddings of a text in its own index, made on the computer with the embedding model chosen there. Pollis's Knowledge Base page (Compose > Knowledge for AI Models > Knowledge Base) switches the texts on and builds the index.

```julia
import PollisKnowledge as PK
PK.catalogue()                                   # the texts
PK.documents("algorithms_for_decision_making")   # downloads the text once, then lists its documents
PK.licence("algorithms_for_decision_making")     # its authors, source and licence
PK.cover("algorithms_for_decision_making")       # the path of its cover
```

## Texts

| Id | Text | Type | Authors | Licence | As kept |
|---|---|---|---|---|---|
| `dive_into_deep_learning` | Dive into Deep Learning, release 1.0.3 | Book | Zhang, Lipton, Li and Smola | CC BY-SA 4.0 | Its Markdown sources, one file a section, without code: the text of the PyTorch tabs kept, cross-references and citations in words, figures as their captions |
| `probabilistic_machine_learning` | Probabilistic Machine Learning: An Introduction, draft of 2025-04-18 | Book | Murphy | CC BY-NC-ND 4.0 | The PDF of its author, unchanged |
| `algorithms_for_optimization` | Algorithms for Optimization, Second Edition, preview | Book | Kochenderfer and Wheeler | CC BY-NC-ND 4.0 | The PDF of its authors, unchanged |
| `algorithms_for_decision_making` | Algorithms for Decision Making | Book | Kochenderfer, Wheeler and Wray | CC BY-NC-ND 4.0 | The PDF of its authors, unchanged |

The algorithms of Algorithms for Optimization and Algorithms for Decision Making are written in Julia. The catalogue, `data/catalogue.toml`, gives each text's page, source and revision. Each artifact holds `LICENCE.md`, with the text's authors, source, what it changes and its licence.

## The Printed Books

These books are open because their authors made them so. Each is also a printed book, and Pollis shows its cover, as its authors show it on its page, with its title, edition, authors, publisher and year, a link to the authors' page and one to the publisher's, where it is sold:

| Book | Authors' page | Publisher |
|---|---|---|
| Dive into Deep Learning | [d2l.ai](https://d2l.ai) | [Cambridge University Press](https://www.cambridge.org/9781009389433) |
| Probabilistic Machine Learning: An Introduction | [probml.github.io](https://probml.github.io/pml-book/book1.html) | [MIT Press](https://mitpress.mit.edu/9780262046824/probabilistic-machine-learning/) |
| Algorithms for Optimization | [algorithmsbook.com](https://algorithmsbook.com/optimization/) | [MIT Press](https://mitpress.mit.edu/9780262058162/algorithms-for-optimization/) |
| Algorithms for Decision Making | [algorithmsbook.com](https://algorithmsbook.com/decisionmaking/) | [MIT Press](https://mitpress.mit.edu/9780262047012/algorithms-for-decision-making/) |

The covers, in `data/covers`, are those of the authors' pages, made smaller; they belong to their publishers and are not under the MIT License of the package.

## Licence

The code of the package is under the MIT License. Each text is under its own licence, above.
