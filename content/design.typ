#set document(title: "Machine Learning & Humanities - Design")

// The style guide: every token and component in `style.css` and
// `components.typ`, rendered live. Published at /design.html, linked from nowhere.

#let section(title, body) = html.elem("section", attrs: (class: "guide-section"))[
  #html.elem("h2", title)
  #body
]

#let spec(body) = html.elem("div", body)

#let row(sample, body) = html.elem("div", attrs: (class: "guide-row"))[#sample#html.elem("span", body)]

#let swatch(value, name) = row(
  html.elem("span", attrs: (class: "guide-swatch", style: "background-color: " + value)),
  [#name: #raw(value)],
)

#let line-sample(value, name) = row(
  html.elem("span", attrs: (class: "guide-line", style: "border-top: 1px solid " + value)),
  [#name: 1px #raw(value)],
)

#let example(source, rendered) = [
  #html.elem("div", attrs: (class: "guide-example"), rendered)
  #html.elem("div", attrs: (class: "guide-code"), raw(block: true, source))
]

#section("Design")[
  The tokens and components machinelearninghumanities.org is built from, shared with drewtran.com.
]

#section("Color")[
  #swatch("#000", "Ink")
  #swatch("#fff", "Paper")
  #swatch("#666", "Muted")
  #swatch("blue", "Link")
  #swatch("lavender", "Side box")
  #swatch("#f0f0f0", "Notice box")
]

#section("Type")[
  Every piece of text is #raw("sans-serif") at 14px with a line height of 1.4em,
  titles and headings included. Hierarchy comes from weight alone.

  The quick brown fox jumps over the lazy dog.

  *The quick brown fox jumps over the lazy dog.*

  Links are #link("https://machinelearninghumanities.org")[blue], underlined on hover.
]

#section("Lines")[
  #line-sample("#ccc", "Rule")
  #line-sample("#aaa", "Box border")
]

#section("Spacing")[
  #spec[Box padding: 8px 14px]
  #spec[Box heading after the first: 8px above]
  #spec[Notice line: 4px above]
  #spec[Paragraph after the first: 1em above]
  #spec[Entity hanging indent: 12px]
  #spec[Section heading after the first: 18px above]
  #spec[Column: 960px, split 1.55:1 with a 26px gap]
  #spec[Side boxes: 14px apart]
  #spec[Below 700px: one column, side column first]
]

#section("Notice")[
  #example(
    "#notice(\"Nothing published yet.\")[\n  Essays, notes and meeting write-ups will be listed here, newest first.\n]",
    notice("Nothing published yet.")[
      Essays, notes and meeting write-ups will be listed here, newest first.
    ],
  )
]

#section("Section head")[
  #example(
    "#section-head(\"Current projects\", more: link(label(\"projects\"))[All projects])",
    section-head("Current projects", more: link(label("projects"))[All projects]),
  )
]

#section("Listing and item")[
  #example(
    "#listing(\n  item(link(\"https://example.org\")[Project title], meta: \"Active · 2026\")[\n    One or two sentences on the question the project asks.\n  ],\n  item([Book title], meta: \"Author · 2020\")[],\n)",
    listing(
      item(link("https://example.org")[Project title], meta: "Active · 2026")[
        One or two sentences on the question the project asks.
      ],
      item([Book title], meta: "Author · 2020")[],
    ),
  )
]

#section("Side box and entity")[
  #example(
    "#side-box(\"Members\")[\n  #entity(role: \"Comparative Literature, UNC\")[Andrew Tran]\n]",
    side-box("Members")[
      #entity(role: "Comparative Literature, UNC")[Andrew Tran]
    ],
  )
]

#section("Page columns")[
  #example(
    "#page-columns(\n  notice(\"Main\")[Writing goes here.],\n  side-box(\"Side\")[Information goes here.],\n)",
    page-columns(
      notice("Main")[Writing goes here.],
      side-box("Side")[Information goes here.],
    ),
  )
]
