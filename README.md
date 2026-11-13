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
| `julia_dynamism_and_performance` | Julia: Dynamism and Performance Reconciled by Design, Proceedings of the ACM on Programming Languages, 2018 | Article | Bezanson, Chen, Chung, Karpinski, Shah, Vitek and Zoubritzky | CC BY 4.0 | The published PDF, unchanged |
| `julia_subtyping` | Julia Subtyping: A Rational Reconstruction, Proceedings of the ACM on Programming Languages, 2018 | Article | Zappa Nardelli, Belyakova, Pelenitsyn, Chung, Bezanson and Vitek | CC BY 4.0 | The published PDF, unchanged |
| `julia_in_machine_learning` | Julia Language in Machine Learning: Algorithms, Applications, and Open Issues, Computer Science Review, 2020 | Article | Gao, Mei, Piccialli, Cuomo, Tu and Huo | CC BY-NC-ND 4.0 | The published PDF, unchanged |
| `modelingtoolkit` | ModelingToolkit: A Composable Graph Transformation System for Equation-Based Modeling, arXiv, version 3 | Article | Ma, Gowda, Anantharaman, Laughman, Shah and Rackauckas | CC BY-NC-ND 4.0 | The arXiv PDF of its authors, unchanged |
| `structuralidentifiability_tutorial` | A Tutorial on Structural Identifiability of Epidemic Models Using StructuralIdentifiability.jl, arXiv, version 5 | Article | Liyanage, Saucedo, Tuncer and Chowell | CC BY 4.0 | The arXiv PDF of its authors, unchanged |
| `infiniteopt` | A unifying modeling abstraction for infinite-dimensional optimization, arXiv, version 2 | Article | Pulsipher, Zhang, Hongisto and Zavala | CC BY 4.0 | The arXiv PDF of its authors, unchanged |
| `agents` | Agents.jl: A performant and feature-full agent based modelling software of minimal code complexity, SIMULATION, 2022 | Article | Datseris, Vahdati and DuBois | CC BY 4.0 | The published PDF, unchanged |
| `archmodels` | ARCHModels.jl: Estimating ARCH Models in Julia, Journal of Statistical Software, 2023 | Article | Broda and Paolella | CC BY 3.0 | The published PDF, unchanged |
| `betaml` | BetaML: The Beta Machine Learning Toolkit, a Self-Contained Repository of Machine Learning Algorithms in Julia, Journal of Open Source Software, 2021 | Article | Lobianco | CC BY 4.0 | The published PDF, unchanged |
| `catalyst` | Catalyst: Fast and Flexible Modeling of Reaction Networks, PLOS Computational Biology, 2023 | Article | Loman, Ma, Ilin, Gowda, Korsbo, Yewale, Rackauckas and Isaacson | CC BY 4.0 | The published PDF, unchanged |
| `complexitymeasures` | ComplexityMeasures.jl: Scalable software to unify and accelerate entropy and complexity timeseries analysis, PLOS One, 2025 | Article | Datseris and Haaga | CC BY 4.0 | The published PDF, unchanged |
| `hypatia_jordan_algebras` | Conic optimization with spectral functions on Euclidean Jordan algebras, arXiv, version 2 | Article | Coey, Kapelevich and Vielma | CC BY 4.0 | The arXiv PDF of its authors, unchanged |
| `copulas` | Copulas.jl: A fully Distributions.jl-compliant copula package, Journal of Open Source Software, 2024 | Article | Laverny and Jimenez | CC BY 4.0 | The published PDF, unchanged |
| `cosmo` | COSMO: A Conic Operator Splitting Method for Convex Conic Problems, Journal of Optimization Theory and Applications, 2021 | Article | Garstka, Cannon and Goulart | CC BY 4.0 | The published PDF, unchanged |
| `differentialequations` | DifferentialEquations.jl: A Performant and Feature-Rich Ecosystem for Solving Differential Equations in Julia, Journal of Open Research Software, 2017 | Article | Rackauckas and Nie | CC BY 4.0 | The published PDF, unchanged |
| `distributions` | Distributions.jl: Definition and Modeling of Probability Distributions in the JuliaStats Ecosystem, Journal of Statistical Software, 2021 | Article | Besançon, Papamarkou, Anthoff, Arslan, Byrne, Lin and Pearson | CC BY 3.0 | The published PDF, unchanged |
| `dynamicalsystems` | DynamicalSystems.jl: A Julia software library for chaos and nonlinear dynamics, Journal of Open Source Software, 2018 | Article | Datseris | CC BY 4.0 | The published PDF, unchanged |
| `symbolics_hash_consing` | Efficient Symbolic Computation via Hash Consing, arXiv, version 2 | Article | Zhu, Sabharwal, Tan, Ma, Edelman and Rackauckas | CC BY 4.0 | The arXiv PDF of its authors, unchanged |
| `jumpprocesses` | Extending JumpProcesses.jl for Fast Point Process Simulation with Time-Varying Intensities, JuliaCon Proceedings, 2024 | Article | Zagatti, Isaacson, Rackauckas, Ilin, Ng and Bressan | CC BY 4.0 | The published PDF, unchanged |
| `extremes` | Extremes.jl: Extreme Value Analysis in Julia, Journal of Statistical Software, 2024 | Article | Jalbert, Farmer, Gobeil and Roy | CC BY 3.0 | The published PDF, unchanged |
| `flux` | Flux: Elegant Machine Learning with Julia, Journal of Open Source Software, 2018 | Article | Innes | CC BY 4.0 | The published PDF, unchanged |
| `frankwolfe` | FrankWolfe.jl: A High-Performance and Flexible Toolbox for Frank-Wolfe Algorithms and Conditional Gradients, arXiv, version 2 | Article | Besançon, Carderera and Pokutta | CC BY 4.0 | The arXiv PDF of its authors, unchanged |
| `gridap` | Gridap: An extensible Finite Element toolbox in Julia, Journal of Open Source Software, 2020 | Article | Badia and Verdugo | CC BY 4.0 | The published PDF, unchanged |
| `symbolics` | High-performance symbolic-numerics via multiple dispatch, arXiv, version 3 | Article | Gowda, Ma, Cheli, Gwóźdź, Shah, Edelman and Rackauckas | CC BY-NC-ND 4.0 | The arXiv PDF of its authors, unchanged |
| `symbolic_numeric_integration` | Hybrid Symbolic-Numeric and Numerically-Assisted Symbolic Integration, Proceedings of the 2024 International Symposium on Symbolic and Algebraic Computation, 2024 | Article | Iravanian, Gowda and Rackauckas | CC BY 4.0 | The published PDF, unchanged |
| `frankwolfe_improved` | Improved algorithms and novel applications of the FrankWolfe.jl library, arXiv, version 2 | Article | Besançon, Designolle, Halbey, Hendrych, Kuzinowicz, Pokutta, Troppens, Herrmannsdoerfer and Wirth | CC BY 4.0 | The arXiv PDF of its authors, unchanged |
| `krylov` | Krylov.jl: A Julia basket of hand-picked Krylov methods, Journal of Open Source Software, 2023 | Article | Montoison and Orban | CC BY 4.0 | The published PDF, unchanged |
| `likelihoodprofiler` | LikelihoodProfiler.jl: Unified profile-likelihood workflows for identifiability and confidence intervals, Journal of Open Source Software, 2026 | Article | Borisov, Demin and Metelkin | CC BY 4.0 | The published PDF, unchanged |
| `macromodelling` | MacroModelling.jl: A Julia package for developing and solving dynamic stochastic general equilibrium models, Journal of Open Source Software, 2023 | Article | Kockerols | CC BY 4.0 | The published PDF, unchanged |
| `makie` | Makie.jl: Flexible high-performance data visualization for Julia, Journal of Open Source Software, 2021 | Article | Danisch and Krumbiegel | CC BY 4.0 | The published PDF, unchanged |
| `manifolds` | Manifolds.jl: An Extensible Julia Framework for Data Analysis on Manifolds, ACM Transactions on Mathematical Software, 2023 | Article | Axen, Baran, Bergmann and Rzecki | CC BY 4.0 | The published PDF, unchanged |
| `manopt` | Manopt.jl: Optimization on Manifolds in Julia, Journal of Open Source Software, 2022 | Article | Bergmann | CC BY 4.0 | The published PDF, unchanged |
| `marswitching` | MarSwitching.jl: A Julia package for Markov switching dynamic models, Journal of Open Source Software, 2024 | Article | Dadej | CC BY 4.0 | The published PDF, unchanged |
| `metaheuristics` | Metaheuristics: A Julia Package for Single- and Multi-Objective Optimization, Journal of Open Source Software, 2022 | Article | Mejía-de-Dios and Mezura-Montes | CC BY 4.0 | The published PDF, unchanged |
| `mlj` | MLJ: A Julia Package for Composable Machine Learning, Journal of Open Source Software, 2020 | Article | Blaom, Kiraly, Lienart, Simillides, Arenas and Vollmer | CC BY 4.0 | The published PDF, unchanged |
| `modelpredictivecontrol` | ModelPredictiveControl.jl: Advanced Process Control Made Easy in Julia, arXiv, version 4 | Article | Gagnon, Thivierge, Desbiens and Bagge Carlson | CC BY 4.0 | The arXiv PDF of its authors, unchanged |
| `nolimits` | NoLimits.jl: Flexible and Composable Nonlinear Mixed-Effects Modeling in Julia, arXiv, version 1 | Article | Huth, Arruda, Schmid, Gusinow, Wieland, Peiter and Hasenauer | CC BY 4.0 | The arXiv PDF of its authors, unchanged |
| `nonlinearsolve` | NonlinearSolve.jl: High-Performance and Robust Solvers for Systems of Nonlinear Equations in Julia, arXiv, version 3 | Article | Pal, Holtorf, Larsson, Loman, Utkarsh, Schäfer, Qu, Edelman and Rackauckas | CC BY 4.0 | The arXiv PDF of its authors, unchanged |
| `structuralidentifiability_observables` | Observable functions of rational ODE models and how to find them, arXiv, version 3 | Article | Demin, Pogudin and Rackauckas | CC BY 4.0 | The arXiv PDF of its authors, unchanged |
| `onlinestats` | OnlineStats.jl: A Julia package for statistics on data streams, Journal of Open Source Software, 2020 | Article | Day and Zhou | CC BY 4.0 | The published PDF, unchanged |
| `optim` | Optim: A mathematical optimization package for Julia, Journal of Open Source Software, 2018 | Article | Mogensen and Riseth | CC BY 4.0 | The published PDF, unchanged |
| `outlierdetection` | OutlierDetection.jl: A Modular Outlier Detection Ecosystem for the Julia Programming Language, arXiv, version 1 | Article | Muhr and Affenzeller | CC BY-SA 4.0 | The arXiv PDF of its authors, unchanged |
| `pathogen` | Pathogen.jl: Infectious Disease Transmission Network Modeling with Julia, Journal of Statistical Software, 2022 | Article | Angevaare, Feng and Deardon | CC BY 3.0 | The published PDF, unchanged |
| `hypatia_interior_point` | Performance enhancements for a generic conic interior point algorithm, Mathematical Programming Computation, 2023 | Article | Coey, Kapelevich and Vielma | CC BY 4.0 | The published PDF, unchanged |
| `petab` | PEtab.jl: Advancing the Efficiency and Utility of Dynamic Modelling, Bioinformatics, 2025 | Article | Persson, Fröhlich, Grein, Loman, Ognissanti, Hasselgren, Hasenauer and Cvijovic | CC BY 4.0 | The published PDF, unchanged |
| `reactive_message_passing` | Reactive Message Passing for Scalable Bayesian Inference, arXiv, version 1 | Article | Bagaev and de Vries | CC BY-NC-SA 4.0 | The arXiv PDF of its authors, unchanged |
| `reactivemp` | ReactiveMP.jl: A Julia package for reactive variational Bayesian inference, Software Impacts, 2022 | Article | Bagaev, van Erp, Podusenko and de Vries | CC BY-NC-ND 4.0 | The published PDF, unchanged |
| `rxinfer` | RxInfer: A Julia Package for Reactive Real-Time Bayesian Inference, Journal of Open Source Software, 2023 | Article | Bagaev, Podusenko and de Vries | CC BY 4.0 | The published PDF, unchanged |
| `sirus` | SIRUS.jl: Interpretable Machine Learning via Rule Extraction, Journal of Open Source Software, 2023 | Article | Huijzer, Blaauw and den Hartigh | CC BY 4.0 | The published PDF, unchanged |
| `hypatia` | Solving Natural Conic Formulations with Hypatia.jl, arXiv, version 5 | Article | Coey, Kapelevich and Vielma | CC BY 4.0 | The arXiv PDF of its authors, unchanged |
| `symbolic_numeric_integration_sparse_regression` | Symbolic-Numeric Integration of Univariate Expressions Based on Sparse Regression, arXiv, version 2 | Article | Iravanian, Martensen, Cheli, Gowda, Jain, Ma and Rackauckas | CC BY 4.0 | The arXiv PDF of its authors, unchanged |
| `taylorseries` | TaylorSeries.jl: Taylor expansions in one and several variables in Julia, Journal of Open Source Software, 2019 | Article | Benet and Sanders | CC BY 4.0 | The published PDF, unchanged |
| `gridap_software_design` | The software design of Gridap: A Finite Element package based on the Julia JIT compiler, Computer Physics Communications, 2022 | Article | Verdugo and Badia | CC BY-NC-ND 4.0 | The accepted version of its authors, unchanged |
| `timeseriessurrogates` | TimeseriesSurrogates.jl: a Julia package for generating surrogate data, Journal of Open Source Software, 2022 | Article | Haaga and Datseris | CC BY 4.0 | The published PDF, unchanged |
| `measurements` | Uncertainty Propagation with Functionally Correlated Quantities, arXiv, version 1 | Article | Giordano | CC BY 4.0 | The arXiv PDF of its authors, unchanged |
| `recurrentlayers` | Unified Implementations of Recurrent Neural Networks in Multiple Deep Learning Frameworks, arXiv, version 1 | Article | Martinuzzi | CC BY 4.0 | The arXiv PDF of its authors, unchanged |

The algorithms of Algorithms for Optimization and Algorithms for Decision Making are written in Julia. Four of the articles are about Julia: its design, its type system, its use in machine learning and ModelingToolkit; the others are about Julia packages that Pollis uses, as their authors describe them in journals and on arXiv. The catalogue, `data/catalogue.toml`, gives each text's page, source and revision. Each artifact holds `LICENCE.md`, with the text's authors, source, what it changes and its licence.

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
