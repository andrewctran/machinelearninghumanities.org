// The site's components. Each emits the classes
// `style.css` draws in HTML, and an equivalent block in PDF and EPUB.

#let BOX-BORDER = rgb("#aaaaaa")
#let BOX-SIDE = rgb("#e6e6fa")
#let BOX-NOTICE = rgb("#f0f0f0")

#let _box(fill, title, body) = block(
  width: 100%,
  fill: fill,
  stroke: 1pt + BOX-BORDER,
  inset: (x: 14pt, y: 8pt),
)[*#title* #parbreak() #body]

// The page's two columns: writing in `main`, information in `side`. The side
// column comes first in PDF and EPUB, as it does on narrow screens.
#let page-columns(main, side) = context if target() == "html" {
  html.elem("div", attrs: (class: "page-columns"))[
    #html.elem("div", attrs: (class: "page-main"), main)
    #html.elem("div", attrs: (class: "page-side"), side)
  ]
} else {
  side
  main
}

// A bold section heading with an optional link to the full page on the right.
#let section-head(title, more: none) = context if target() == "html" {
  html.elem("div", attrs: (class: "section-head"))[
    #html.elem("h3", title)
    #if more != none { more }
  ]
} else {
  block(above: 1.2em, below: 0.6em)[*#title*]
}

// A bordered list of `item`s, such as projects or meetings.
#let listing(..items) = context if target() == "html" {
  html.elem("div", attrs: (class: "listing"), items.pos().join())
} else {
  items.pos().join()
}

// One entry in a `listing`: a title, an optional muted meta line (status,
// authors, year) and an optional description.
#let item(title, meta: none, body) = context if target() == "html" {
  html.elem("div", attrs: (class: "listing-item"))[
    #html.elem("div", attrs: (class: "listing-title"), title)
    #if meta != none { html.elem("div", attrs: (class: "listing-meta"), meta) }
    #body
  ]
} else {
  block(below: 0.8em)[
    *#title* #if meta != none [ (#meta)] \
    #body
  ]
}

// A gray box for a short message, such as an empty state.
#let notice(title, body) = context if target() == "html" {
  html.elem("div", attrs: (class: "notice"))[
    #html.elem("h4", title)
    #body
  ]
} else {
  _box(BOX-NOTICE, title, body)
}

// A lavender box of information beside the writing.
#let side-box(title, body) = context if target() == "html" {
  html.elem("div", attrs: (class: "side-box"))[
    #html.elem("h4", title)
    #body
  ]
} else {
  _box(BOX-SIDE, title, body)
}

// One item in a side box, with an optional parenthetical note after it.
#let entity(body, role: none) = context if target() == "html" {
  html.elem("div", attrs: (class: "entity"))[
    #body#if role != none [ #html.elem("span", attrs: (class: "role"))[(#role)]]
  ]
} else {
  block(below: 0.4em)[#body#if role != none [ (#role)]]
}
