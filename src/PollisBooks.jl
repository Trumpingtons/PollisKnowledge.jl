"""
	PollisBooks

Open books that Pollis searches as a collection of its own, PollisBooks, beside the collections of Compose >
Retrieval-Augmented Generation, so that Ask Pollis can answer from them. Each book is an artifact of the package,
downloaded the first time it is asked for, with its licence:

```julia
import PollisBooks as PBk
PBk.books()                                # the catalogue
PBk.documents("algorithms_for_decision_making")  # downloads the book once, then lists its documents
```

The books are those whose licence lets them be shared as they are; Dive into Deep Learning is shared converted from
its Markdown sources without its code, as its licence, CC BY-SA 4.0, allows. Pollis keeps the passages and the
embeddings of a book in its own index, made on the computer with the embedding model chosen there.
"""
module PollisBooks

import TOML
using Artifacts: artifact_exists, artifact_hash, artifact_path
using Pkg.Artifacts: ensure_artifact_installed

"""The catalogue of the books, `data/catalogue.toml`."""
const CATALOGUE_FILE = joinpath(dirname(@__DIR__), "data", "catalogue.toml")
include_dependency(CATALOGUE_FILE)
const CATALOGUE = TOML.parsefile(CATALOGUE_FILE)["books"]

"""The artifacts of the books, one per book, named by its id."""
const ARTIFACTS_FILE = joinpath(dirname(@__DIR__), "Artifacts.toml")

"""
	books()

The entries of the catalogue, one per book, in its order: id, title, edition, authors, publisher, year, subject, kind
("pdf" or "markdown"), licence, licence_url, page (the book's page on its authors' site), revision, size_mb and, for some,
download (where the build fetched it from) and changes (what the artifact leaves out of the book, or changes in it).
"""
books() = CATALOGUE

"""The entry of the catalogue of the book `id`."""
function book(id)
	index = findfirst(entry -> entry["id"] == String(id), CATALOGUE)
	index === nothing && error("No book $(id) in PollisBooks: it has $(join([entry["id"] for entry in CATALOGUE], ", ")).")
	CATALOGUE[index]
end

"""The hash of the artifact of the book `id`, or nothing when the package has none for it."""
function book_hash(id)
	book(id)
	isfile(ARTIFACTS_FILE) ? artifact_hash(String(id), ARTIFACTS_FILE) : nothing
end

"""
	downloaded(id)

Whether the book `id` is on this computer, its artifact downloaded.
"""
function downloaded(id)
	hash = book_hash(id)
	hash !== nothing && artifact_exists(hash)
end

"""
	path(id)

The folder of the book `id`: its files, `contents.toml` and `LICENCE.md`. The book is downloaded the first time, from
the release of PollisBooks.jl that holds it, not from a server of Julia packages, which does not have it.
"""
function path(id)
	book_hash(id) === nothing && error("PollisBooks has no artifact of $(book(id)["title"]) yet.")
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

The documents of the book `id`, in their order, each `(; file, title, kind)`: its path, its title and its kind, "pdf"
or "markdown". A book in PDF is one document, which Pollis cuts by its bookmarks; one from Markdown has a document
for each section. The book is downloaded the first time.
"""
function documents(id)
	folder = path(id)
	[(; file = joinpath(folder, entry["file"]), title = entry["title"], kind = entry["kind"])
	 for entry in TOML.parsefile(joinpath(folder, "contents.toml"))["documents"]]
end

"""
	licence(id)

The text of `LICENCE.md` of the book `id`: its authors, where it comes from, what it leaves out, and its licence.
"""
licence(id) = read(joinpath(path(id), "LICENCE.md"), String)

include("markdown.jl")

end
