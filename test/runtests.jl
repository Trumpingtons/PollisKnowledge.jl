using PollisKnowledge
using Test
import TOML

const PK = PollisKnowledge

# The expected values are worked out by hand from the rules the docstrings state, not from the code.

@testset "PollisKnowledge" begin
	@testset "Catalogue" begin
		ids = [entry["id"] for entry in PK.catalogue()]
		# The four books, then the 56 articles
		@test ids[1:4] == ["dive_into_deep_learning", "probabilistic_machine_learning", "algorithms_for_optimization",
			"algorithms_for_decision_making"]
		@test length(ids) == 60 && allunique(ids)
		@test [entry["type"] for entry in PK.catalogue()] == [fill("Book", 4); fill("Article", 56)]
		keys = ["id", "reference", "title", "type", "edition", "authors", "publisher", "year", "subject", "format", "licence", "licence_url", "page", "revision", "size_mb"]
		@test all(entry -> all(key -> haskey(entry, key), keys), PK.catalogue())
		@test PK.catalogue_entry("dive_into_deep_learning")["format"] == "markdown"
		@test PK.catalogue_entry("recurrentlayers")["packages"] == ["RecurrentLayers.jl", "LuxRecurrentLayers.jl"]
		@test_throws ErrorException PK.catalogue_entry("islp")
	end

	@testset "Artifacts" begin
		# Every text has its artifact, and only they have one
		@test Set(Base.keys(TOML.parsefile(PK.ARTIFACTS_FILE))) == Set(entry["id"] for entry in PK.catalogue())
	end

	@testset "Covers" begin
		books = filter(entry -> entry["type"] == "Book", PK.catalogue())
		@test all(entry -> isfile(PK.cover(entry["id"])), books)
		@test basename(PK.cover("algorithms_for_decision_making")) == "algorithms_for_decision_making.jpg"
		@test all(entry -> startswith(entry["hard_copy"], "https://"), books)
		@test PK.cover("manifolds") === nothing
	end

	@testset "Prose of a section" begin
		text = "```{.python .input}\n%%tab pytorch\nimport torch\n```\n\n# Title\n:label:`sec_t`\n\n:begin_tab:`mxnet`\nMX text\n:end_tab:\n\n:begin_tab:`pytorch`\nTorch text\n:end_tab:\nEnd."
		@test PK.d2l_prose(text) == ["", "# Title", ":label:`sec_t`", "", "", "Torch text", "End."]
		@test PK.d2l_title(PK.d2l_prose(text)) == "Title"
	end

	@testset "Labels" begin
		section = "# Softmax Regression\n:label:`sec_softmax`\n\n![A network.](../img/x.svg)\n:width:`300px`\n:label:`fig_net`\n\n\$\$y = x\$\$\n:eqlabel:`eq_y`\n\n| a | b |\n|---|---|\n:label:`tab_ab`"
		labels = PK.d2l_labels!(Dict{String, String}(), section)
		PK.d2l_labels!(labels, "# Linear Networks\n:label:`chap_linear`\n\n\$\$a = b,\$\$ :eqlabel:`eq_ab`")
		@test labels == Dict(
			"sec_softmax" => "the section “Softmax Regression”",
			"fig_net" => "the figure “A network”",
			"eq_y" => "an equation of the section “Softmax Regression”",
			"tab_ab" => "a table of the section “Softmax Regression”",
			"chap_linear" => "the chapter “Linear Networks”",
			"eq_ab" => "an equation of the section “Linear Networks”")
	end

	@testset "Markdown of a section" begin
		labels = Dict("sec_softmax" => "the section “Softmax Regression”", "fig_net" => "the figure “A network”",
			"eq_y" => "an equation of the section “Softmax Regression”")
		citations = Dict("Nair.Hinton.2010" => (; names = "Nair and Hinton", year = "2010"))
		text = "# MLP\n:label:`sec_mlp`\n\nIn :numref:`sec_softmax`, see :numref:`fig_net` and :eqref:`eq_y`.\nReLU :cite:`Nair.Hinton.2010,Unknown.2020` as :citet:`Nair.Hinton.2010` showed.\n\n![An MLP.](../img/mlp.svg)\n:label:`fig_mlp`\n\n[**The sigmoid**] maps\n(**to (0, 1).**)\n\n\n\n:numref:`sec_missing` ends, as :ref:`sec_softmax` and :numref:``sec_softmax`` say.\n\$\$a = b,\$\$ :eqlabel:`eq_ab`\nEquation :eqref:`eq_y` holds."
		@test PK.d2l_markdown(text, labels, citations) ==
			"# MLP\n\nIn the section “Softmax Regression”, see the figure “A network” and an equation of the section “Softmax Regression”.\nReLU (Nair and Hinton 2010; Unknown.2020) as Nair and Hinton (2010) showed.\n\n*Figure: An MLP.*\n\nThe sigmoid maps\nto (0, 1).\n\nanother section ends, as the section “Softmax Regression” and the section “Softmax Regression” say.\n\$\$a = b,\$\$\nAn equation of the section “Softmax Regression” holds.\n"
	end

	@testset "Citations" begin
		bib = """@InProceedings{ Nair.Hinton.2010,
		  title = {Rectified linear units},
		  author = {Nair, Vinod and Hinton, Geoffrey E},
		  year = {2010}
		}

		@Article{ Scholkopf.2002,
		  author = {Bernhard Sch{\\"o}lkopf and Mart{\\'\\i}nez, Ana and others},
		  year = 2002
		}
		@Misc{ NoAuthor,
		  title = {x}
		}"""
		@test PK.bib_citations(bib) == Dict(
			"Nair.Hinton.2010" => (; names = "Nair and Hinton", year = "2010"),
			"Scholkopf.2002" => (; names = "Schölkopf, Martínez and others", year = "2002"))
		@test [PK.latex_text(text) for text in ["Gau{\\ss}", "Fran\\c{c}ois", "Erd\\H{o}s", "{van der Maaten}"]] ==
			["Gauß", "François", "Erdős", "van der Maaten"]
	end

	@testset "Tables of contents" begin
		text = "Intro\n\n```toc\n:maxdepth: 1\n\nchapter_preface/index\n```\n\n```toc\n:maxdepth: 2\n:numbered:\n\nchapter_introduction/index\nchapter_mlp/index.md\n```"
		@test PK.d2l_toc(text) == [(; entry = "chapter_preface/index", numbered = false),
			(; entry = "chapter_introduction/index", numbered = true), (; entry = "chapter_mlp/index", numbered = true)]
	end
end
