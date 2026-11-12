# Dive into Deep Learning from its Markdown sources (github.com/d2l-ai/d2l-en), as the artifact keeps it: its prose,
# without code. The build of the artifact uses these functions; they are here so that the tests can check them.

"""The tab of Dive into Deep Learning whose text is kept; the text of the others is left out."""
const D2L_TAB = "pytorch"

"""Whether `line` opens or closes a fenced block."""
is_fence(line) = startswith(lstrip(line), "```")

"""Whether `line` is a directive of d2lbook alone on its line, such as `:label:` or `:width:`, which says nothing to a reader."""
is_directive(line) = occursin(r"^:(label|eqlabel|width|height):", line)

"""
	d2l_prose(text)

The lines of the source `text` of a section without its fenced blocks (code, its output, tables of contents and
blocks of reStructuredText) and without the text of the tabs of other frameworks than PyTorch.
"""
function d2l_prose(text)
	lines = String[]
	in_fence = false
	tab = :none
	for line in split(text, '\n')
		if is_fence(line)
			in_fence = !in_fence
			continue
		end
		in_fence && continue
		opening = match(r"^:begin_tab:`(?<tabs>[^`]*)`", line)
		if opening !== nothing
			tab = D2L_TAB in strip.(split(opening[:tabs], ',')) ? :keep : :drop
			continue
		end
		if startswith(line, ":end_tab:")
			tab = :none
			continue
		end
		tab === :drop || push!(lines, String(line))
	end
	lines
end

"""The title of a section, its first heading of level 1, from its lines; empty when it has none."""
function d2l_title(lines)
	for line in lines
		heading = match(r"^#\s+(?<title>.+?)\s*$", line)
		heading === nothing || return String(heading[:title])
	end
	""
end

"""
	d2l_labels!(labels, text)

Adds to `labels` the labels of the source `text` of a section, each with the words it is written as: a heading as the
chapter (label `chap_…`) or the section of its title, a figure by its caption, a table or an equation by the section
it is in.
"""
function d2l_labels!(labels, text)
	lines = d2l_prose(text)
	title = d2l_title(lines)
	previous = ""
	for line in lines
		label = match(r"^:(?<kind>label|eqlabel):`(?<name>[^`]+)`", line)
		inline = match(r"\S\s*:eqlabel:`(?<name>[^`]+)`", line)
		inline === nothing || (labels[inline[:name]] = label_words("eqlabel", inline[:name], line, title))
		if label !== nothing
			labels[label[:name]] = label_words(label[:kind], label[:name], previous, title)
		elseif !isempty(strip(line)) && !is_directive(line)
			previous = line
		end
	end
	labels
end

"""The words a label is written as, from the line it follows."""
function label_words(kind, name, previous, title)
	heading = match(r"^#+\s+(?<heading>.+?)\s*$", previous)
	figure = match(r"^!\[(?<caption>[^\]]*)\]", previous)
	if kind == "label" && heading !== nothing
		startswith(name, "chap_") ? "the chapter “$(heading[:heading])”" : "the section “$(heading[:heading])”"
	elseif kind == "label" && figure !== nothing
		"the figure “$(rstrip(figure[:caption], '.'))”"
	elseif kind == "label" && startswith(previous, "|")
		"a table of the section “$(title)”"
	else
		"an equation of the section “$(title)”"
	end
end

"""`text` with each match of `pattern` replaced by `f(match)`."""
function substitute(f, text, pattern)
	out = IOBuffer()
	last = 1
	for found in eachmatch(pattern, text)
		print(out, SubString(text, last, prevind(text, found.offset)), f(found))
		last = found.offset + ncodeunits(found.match)
	end
	print(out, SubString(text, last))
	String(take!(out))
end

"""The label a reference names: `label`, or `label` of `words <label>`."""
function referred(name)
	inside = match(r"<(?<label>[^>]+)>", name)
	String(strip(inside === nothing ? name : inside[:label]))
end

"""
	d2l_markdown(text, labels, citations)

The Markdown of a section of Dive into Deep Learning as the artifact keeps it, from its source `text`: its prose
(`d2l_prose`) without the directives of d2lbook; a figure as its caption; a cross-reference in words, from `labels`,
`equation` before a reference to an equation left out;
a citation by surnames and year, from `citations` (`bib_citations`); the highlight marks `[**…**]` and `(**…**)`
of d2lbook left out, their text kept.
"""
function d2l_markdown(text, labels, citations)
	lines = String[]
	for line in d2l_prose(text)
		is_directive(line) && continue
		figure = match(r"^!\[(?<caption>[^\]]*)\]\([^)]*\)\s*$", line)
		if figure !== nothing
			isempty(strip(figure[:caption])) || push!(lines, "*Figure: $(strip(figure[:caption]))*")
		else
			push!(lines, line)
		end
	end
	markdown = replace(join(lines, '\n'), r"\s*:eqlabel:`[^`]+`" => "")
	markdown = substitute(markdown, r":(?:numref|ref):`+(?<name>[^`]+)`+") do found
		get(labels, referred(found[:name]), "another section")
	end
	markdown = substitute(markdown, r"(?<word>[Ee]quation\s+)?:eqref:`(?<name>[^`]+)`") do found
		words = get(labels, referred(found[:name]), "an equation")
		found[:word] !== nothing && startswith(found[:word], 'E') ? uppercasefirst(words) : words
	end
	markdown = substitute(markdown, r":(?<role>citet?):`(?<keys>[^`]+)`") do found
		cited = [cited_words(get(citations, key, nothing), key, found[:role] == "citet") for key in strip.(split(found[:keys], ','))]
		found[:role] == "citet" ? join(cited, "; ") : "(" * join(cited, "; ") * ")"
	end
	markdown = replace(markdown, r"\[\*\*(?<text>.*?)\*\*\]"s => s"\g<text>", r"\(\*\*(?<text>.*?)\*\*\)"s => s"\g<text>")
	strip(replace(markdown, r"\n{3,}" => "\n\n")) * "\n"
end

"""A citation in words: `Surnames year`, or `Surnames (year)` in the text; the key itself when the bibliography lacks it."""
function cited_words(citation, key, in_text)
	citation === nothing && return String(key)
	in_text ? "$(citation.names) ($(citation.year))" : "$(citation.names) $(citation.year)"
end

# The accents of LaTeX, as combining marks, and its letters of their own
const ACCENTS = Dict('"' => '\u0308', '\'' => '\u0301', '`' => '\u0300', '^' => '\u0302', '~' => '\u0303', '=' => '\u0304',
	'.' => '\u0307', 'u' => '\u0306', 'v' => '\u030C', 'H' => '\u030B', 'c' => '\u0327', 'k' => '\u0328')
const LETTERS = Dict("ss" => "ß", "aa" => "å", "AA" => "Å", "ae" => "æ", "AE" => "Æ", "oe" => "œ", "OE" => "Œ",
	"o" => "ø", "O" => "Ø", "l" => "ł", "L" => "Ł", "i" => "i", "j" => "j")

"""`text` of a field of BibTeX as plain text: its accents and letters of LaTeX as Unicode, without braces."""
function latex_text(text)
	text = substitute(text, r"\\(?<name>ss|aa|AA|ae|AE|oe|OE|o|O|l|L|i|j)(?![A-Za-z])") do found
		LETTERS[found[:name]]
	end
	text = substitute(text, r"\\(?<accent>[\"'`^~=.])\s*\{?\s*(?<letter>[A-Za-z])\}?") do found
		found[:letter] * ACCENTS[found[:accent][1]]
	end
	text = substitute(text, r"\\(?<accent>[uvHck])(?:\s+|\{)(?<letter>[A-Za-z])\}?") do found
		found[:letter] * ACCENTS[found[:accent][1]]
	end
	text = replace(text, r"[{}]" => "", r"\s+" => " ")
	Base.Unicode.normalize(String(strip(text)), :NFC)
end

"""The field `name` of the entry `entry` of BibTeX, as written between its braces or quotes; nothing when it has none."""
function braced_field(entry, name)
	start = match(Regex("(?i)\\b$(name)\\s*=\\s*"), entry)
	start === nothing && return nothing
	index = start.offset + ncodeunits(start.match)
	index > ncodeunits(entry) && return nothing
	opening = entry[index]
	if opening == '{'
		depth = 0
		for position in index:ncodeunits(entry)
			isvalid(entry, position) || continue
			character = entry[position]
			depth += character == '{' ? 1 : character == '}' ? -1 : 0
			depth == 0 && return SubString(entry, nextind(entry, index), prevind(entry, position))
		end
		nothing
	elseif opening == '"'
		closing = findnext('"', entry, nextind(entry, index))
		closing === nothing ? nothing : SubString(entry, nextind(entry, index), prevind(entry, closing))
	else
		value = match(r"^[^,\s}]+", SubString(entry, index))
		value === nothing ? nothing : value.match
	end
end

"""The surname of an author of BibTeX, written `Surname, Given` or `Given Surname`."""
function surname(author)
	author = strip(author)
	occursin(',', author) && return latex_text(first(split(author, ',')))
	# The last word outside braces: `{van der Maaten}` is one word
	words = String[]
	depth = 0
	current = IOBuffer()
	for character in author
		depth += character == '{' ? 1 : character == '}' ? -1 : 0
		if isspace(character) && depth == 0
			word = String(take!(current))
			isempty(word) || push!(words, word)
		else
			print(current, character)
		end
	end
	word = String(take!(current))
	isempty(word) || push!(words, word)
	latex_text(last(words))
end

"""The surnames of the authors of BibTeX `authors`, in words: `A`, `A and B`, `A, B and C`; `others` as `and others`."""
function author_words(authors)
	names = [String(strip(name)) for name in split(replace(authors, r"\s+" => " "), r"\s+and\s+")]
	others = any(name -> lowercase(name) in ("others", "et al.", "et al"), names)
	surnames = [surname(name) for name in names if !(lowercase(name) in ("others", "et al.", "et al"))]
	others && push!(surnames, "others")
	length(surnames) <= 2 ? join(surnames, " and ") : join(surnames[1:(end - 1)], ", ") * " and " * last(surnames)
end

"""
	bib_citations(bib)

The citations of the bibliography `bib`, in BibTeX, by key: `(; names, year)`, the surnames of its authors in words
(`author_words`) and its year. An entry without authors or year is left out.
"""
function bib_citations(bib)
	citations = Dict{String, @NamedTuple{names::String, year::String}}()
	for entry in split(bib, r"\n(?=\s*@)")
		key = match(r"@\w+\s*\{\s*(?<key>[^,\s]+)\s*,", entry)
		key === nothing && continue
		authors = braced_field(entry, "author")
		year = braced_field(entry, "year")
		(authors === nothing || year === nothing) && continue
		citations[key[:key]] = (; names = author_words(authors), year = String(strip(year)))
	end
	citations
end

"""
	d2l_toc(text)

The entries of the tables of contents (blocks `toc`) of the source `text`, in their order: `(; entry, numbered)`,
the file named without `.md`, whether written with it or not, and whether the block numbers its entries.
"""
function d2l_toc(text)
	entries = @NamedTuple{entry::String, numbered::Bool}[]
	in_toc = false
	numbered = false
	for line in split(text, '\n')
		line = strip(line)
		if startswith(line, "```toc")
			in_toc, numbered = true, false
		elseif in_toc && startswith(line, "```")
			in_toc = false
		elseif in_toc && line == ":numbered:"
			numbered = true
		elseif in_toc && !isempty(line) && !startswith(line, ":")
			push!(entries, (; entry = String(chopsuffix(line, ".md")), numbered))
		end
	end
	entries
end
