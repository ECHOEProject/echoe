# ECHOE

Electronic Corpus of Anonymous Homilies in Old English

## About

ECHOE is a text corpus encoding all extant witnesses to anonymous and Wulfstanian Old English homiletic and long-format hagiographic prose predating c. 1200 in TEI P5 XML. It forms the basis of [ECHOE Online](https://echoe.uni-goettingen.de). Consult the [documentation](doc/documentation.pdf) for a detailed account of the corpus and the underlying design principles.

## Repository Structure

| Folder      |	Description						   						           |
| ----------- |	------------------------------------------------------------------ |
| `data`      |	JSON data used by [ECHOE Online](https://echoe.uni-goettingen.de)  |
| `doc`	      |	[User manual](doc/documentation.pdf)					           |
| `ebook`     |	EPUB release							   						   |
| `misc`      |	Project ODD; sample transformation stylesheets					   |
| `plaintext` |	A plaintext rendering of the corpus					               |
| `xml`	      |	XML corpus							                               |

The plaintext corpus, included as a courtesy to the user, represents a normalized transformation that accepts the most recent scribal revision as well as all editorial emendations. The stylesheets included in `misc/` may be consulted or adapted for the purpose of custom transformation.
