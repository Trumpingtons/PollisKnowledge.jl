"""
	PollisKnowledge

Openly licensed texts that Pollis searches as a collection of its own, the Knowledge Base, beside the collections of
Compose > Retrieval-Augmented Generation, so that Ask Pollis can answer from them: books, lecture notes, reports,
manuals and other written works. Each text is an artifact of the package, downloaded the first time it is asked for,
with its licence:

```julia
import PollisKnowledge as PK
PK.catalogue()                                   # the texts
PK.documents("algorithms_for_decision_making")   # downloads the text once, then lists its documents
PK.licence("algorithms_for_decision_making")     # its authors, source and licence
PK.cover("algorithms_for_decision_making")       # the path of its cover
```

The texts are those whose licence lets them be shared; a text converted from its sources, such as Dive into Deep
Learning from its Markdown without its code, says what it changes, as its licence asks. Pollis keeps the passages and
the embeddings of a text in its own index, made on the computer with the embedding model chosen there.
"""
module PollisKnowledge

import TOML
using Artifacts: artifact_exists, artifact_hash
using Pkg.Artifacts: ensure_artifact_installed

"""The catalogue of the texts, `data/catalogue.toml`."""
const CATALOGUE_FILE = joinpath(dirname(@__DIR__), "data", "catalogue.toml")
include_dependency(CATALOGUE_FILE)
const CATALOGUE = TOML.parsefile(CATALOGUE_FILE)["texts"]

"""The artifacts of the texts, one per text, named by its id."""
const ARTIFACTS_FILE = joinpath(dirname(@__DIR__), "Artifacts.toml")

"""
	catalogue()

The entries of the catalogue, one per text, in its order: id, title, type (Book, Lecture Notes, Report, Manual...),
edition, authors, publisher, year, subject, format ("pdf" or "markdown"), licence, licence_url, page (the text's page
on its authors' site), revision, size_mb and, for some, download (where the build fetched it from) and changes (what
the artifact leaves out of the text, or changes in it). A published book has cover (its file, see `cover`),
cover_from (where its authors show it) and hard_copy (its publisher's page, where the printed book is sold).
"""
catalogue() = CATALOGUE

"""The entry of the catalogue of the text `id`."""
function catalogue_entry(id)
	index = findfirst(entry -> entry["id"] == String(id), CATALOGUE)
	index === nothing && error("No text $(id) in PollisKnowledge: it has $(join([entry["id"] for entry in CATALOGUE], ", ")).")
	CATALOGUE[index]
end

"""The hash of the artifact of the text `id`, or nothing when the package has none for it."""
function text_hash(id)
	catalogue_entry(id)
	isfile(ARTIFACTS_FILE) ? artifact_hash(String(id), ARTIFACTS_FILE) : nothing
end

"""
	cover(id)

The path of the cover of the text `id`, as its authors show it on its page, which comes with the package; nothing for
a text without one.
"""
function cover(id)
	file = get(catalogue_entry(id), "cover", nothing)
	file === nothing ? nothing : joinpath(dirname(@__DIR__), "data", "covers", file)
end

"""
	downloaded(id)

Whether the text `id` is on this computer, its artifact downloaded.
"""
function downloaded(id)
	hash = text_hash(id)
	hash !== nothing && artifact_exists(hash)
end

"""
	path(id)

The folder of the text `id`: its files, `contents.toml` and `LICENCE.md`. The text is downloaded the first time, from
the release of PollisKnowledge.jl that holds it, not from a server of Julia packages, which does not have it.
"""
function path(id)
	text_hash(id) === nothing && error("PollisKnowledge has no artifact of $(catalogue_entry(id)["title"]) yet.")
	try
		ensure_artifact_installed(String(id), ARTIFACTS_FILE; pkg_server_eligible = false)
	catch failure
		# A Pkg older than the keyword tries the server first, then the release
		failure isa MethodError || rethrow()
		ensure_artifact_installed(String(id), ARTIFACTS_FILE)
	end
end

"""
	documents(id)

The documents of the text `id`, in their order, each `(; file, title, kind)`: its path, its title and its kind, "pdf"
or "markdown". A text in PDF is one document, which Pollis cuts by its bookmarks; one from Markdown has a document
for each section. The text is downloaded the first time.
"""
function documents(id)
	folder = path(id)
	[(; file = joinpath(folder, entry["file"]), title = entry["title"], kind = entry["kind"])
	 for entry in TOML.parsefile(joinpath(folder, "contents.toml"))["documents"]]
end

"""
	licence(id)

The text of `LICENCE.md` of the text `id`: its authors, where it comes from, what it changes, and its licence.
"""
licence(id) = read(joinpath(path(id), "LICENCE.md"), String)

include("markdown.jl")

end
