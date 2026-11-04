# machinelearninghumanities.org

The site of the Machine Learning Humanities working group, published at [machinelearninghumanities.org](https://machinelearninghumanities.org).

The site is written in [Typst](https://typst.app) and compiled by [Rheo](https://rheo.ohrg.org), a static site engine, with [Rookery](https://rookery.ohrg.org) loaded for writing. It shares its design system with [drewtran.com](https://drewtran.com) ([source](https://github.com/andrewctran/andrewctran.github.io)). GitHub Actions builds the site and deploys it to GitHub Pages on every push to `main`.

## Quick start

You need `bash`, `curl` and `unzip` on macOS or Linux, plus [`just`](https://github.com/casey/just), a command runner (`brew install just`). You don't need to install Rheo: `bin/rheo` downloads the version pinned in `rheo.toml` into `.rheo-binary/` the first time it runs.

```sh
just dev
```

This compiles the site, serves it at http://localhost:3000, and opens it in your browser. Saving any file under `content/` or `style.css` rebuilds the site and reloads the page. Stop the server with Ctrl+C.

## Commands

| Command | What it does |
| --- | --- |
| `just dev` | Serves the site at http://localhost:3000 with live reload. |
| `just build` | Builds the deployable site into `build/html`, the same way CI does. |
| `just print` | Builds the PDF and EPUB editions into `build/pdf` and `build/epub`. |
| `just clean` | Deletes `build/`. |

Run `bin/rheo` directly for anything else; it passes its arguments to Rheo, for example `bin/rheo --version`.

## Project layout

```
content/
  index.typ            homepage: project/writing/reading sections, About the group and Join
  projects.typ         /projects.html
  writing.typ          /writing.html, the index of Rookery writing
  readings.typ         /readings.html
  join.typ             /join.html: meetings and contact
  design.typ           style guide, published as /design.html (linked from nowhere)
  _lib/
    prelude.typ        spliced into the top of every page
    template.typ       header and nav, footer, page titles and the Rookery theme
    components.typ     page-columns, section-head, listing, item, notice, side-box, entity
style.css              every style on the site
rheo.toml              Rheo settings: content directory, stylesheet, PDF/EPUB spines, packages
Justfile               the dev, build, print and clean recipes
bin/rheo               runs the pinned Rheo, downloading it on first use
build.sh               the production build used by CI and `just build`
CNAME                  the custom domain, copied into the build for GitHub Pages
.github/workflows/     the deploy workflow
```

## How a page is built

Every `.typ` file in `content/` outside `_lib/` becomes a page, so `content/events.typ` is published at `/events.html`. Rheo splices `content/_lib/prelude.typ` into the top of each one. The prelude imports the components and Rookery's `idea`, `window`, `outline` and `footnote`, and wraps the page in `template`, passing the page's label (its file name without `.typ`) so the header nav can mark the current page. A page can call any component without importing it, and gets the header and footer automatically.

A page sets its own title on its first line, as "Machine Learning Humanities - " and the page name:

```typst
#set document(title: "Machine Learning Humanities - Projects")
```

To add a page to the header nav, add a `(name, label)` pair to `NAV` in `template.typ`.

Link to another page by its label. Rheo turns `#link(label("join"))[Join]` into a link to `join.html`.

## Design system

The tokens, type and spacing are drewtran.com's, unchanged: `sans-serif` at 14px with hierarchy from bold alone, lavender side boxes, `#f0f0f0` notices, 1px rules, blue links, and a 960px column split 1.55:1 into main and side columns that stack below 700px. See that repository's README for the full token table. Live examples of everything are at `/design.html`.

This site adds three things for an organization:

- **Header nav.** It replaces drewtran.com's Subscribe link. The current page is shown in bold ink instead of as a link.
- **`section-head`.** A bold heading with an optional link to the full page on the right. Section heads after the first get 18px above them.
- **`listing` and `item`.** A bordered stack of entries, each with a title, a muted meta line and an optional description, separated by 1px rules.

```typst
#section-head("Current projects", more: link(label("projects"))[All projects])

#listing(
  item(link("https://example.org")[Project title], meta: "Active · 2026")[
    One or two sentences on the question the project asks.
  ],
  item([Book title], meta: "Author · 2020")[],
)
```

To add a component, define it in `components.typ` with a `context if target() == "html"` branch and a fallback for other outputs. Export it through the import line in `prelude.typ`, style its classes in `style.css`, and add a live example to `content/design.typ`.

## Content

Projects are a `listing` in `projects.typ`. Sections without content yet show a `notice` empty state; to fill one in, replace the notice with a `listing`, as `projects.typ` does and as the comment in `readings.typ` shows. The homepage repeats each section, so update it alongside the section's page.

Writing uses Rookery; see the [Rookery documentation](https://rookery.ohrg.org) for how ideas and windows work. A comment in `site-header` in `template.typ` marks where `@rookery/search`'s search modal goes once there is something to search.

## PDF and EPUB

`just print` compiles every page in the spine into one PDF and one EPUB titled "Machine Learning Humanities". The style guide is left out through the `exclude` lists under `[pdf.spine]` and `[epub.spine]` in `rheo.toml`. These lists replace the top-level `[spine] exclude` rather than adding to it, so each repeats `_lib/**`.

## Deployment

`.github/workflows/deploy.yml` runs on every push to `main`, and can also be started by hand from the Actions tab. It restores `.rheo-binary/` from cache, runs `bash build.sh`, and publishes `build/html` to GitHub Pages. The repository's Pages source must stay set to "GitHub Actions".

`build.sh` deletes `build/html` before compiling, because Rheo never removes files it didn't write. Rheo publishes only the pages, the stylesheet and its package assets, so `build.sh` copies `CNAME` in afterwards.

To upgrade Rheo, change `version` in `rheo.toml`. `bin/rheo` downloads the new release on its next run, and CI picks it up because its cache key is a hash of `rheo.toml`.

## Domain

DNS is at Hover. The apex has four A records pointing at GitHub Pages (`185.199.108.153` to `185.199.111.153`), and `www` is a CNAME to `andrewctran.github.io`. See [GitHub's custom domain documentation](https://docs.github.com/en/pages/configuring-a-custom-domain-for-your-github-pages-site/managing-a-custom-domain-for-your-github-pages-site).
