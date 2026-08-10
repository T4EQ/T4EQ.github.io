# T4EQ — Tech for Equality

Source for the [Tech for Equality](https://t4eq.org) website — a static site
built with [Hugo](https://gohugo.io/) (extended), with all templates and
styles hand-built in this repository (no external theme).

## Requirements

- **Hugo extended**, `v0.163.3` or newer.
  Prebuilt binaries: <https://github.com/gohugoio/hugo/releases>.
  On macOS: `brew install hugo`.
  With nix: `nix develop`.

## Local development

Serve the site with live reload at <http://localhost:1313>:

```sh
hugo server --disableFastRender --noHTTPCache
```

Produce a production build into `public/`:

```sh
hugo --minify
```

## Project structure

```
hugo.toml        -> Site configuration (baseURL, menus, params).
content/         -> Page content and front matter (Markdown).
data/            -> Structured data (team.yaml, services.yaml).
static/          -> Assets served as-is:
  css/main.css   ->   The single active stylesheet.
  js/main.js     ->   Site JavaScript (nav, contact form).
  images/        ->   Logos, team photos, mockups.
layouts/         -> The ACTIVE templates that render the site:
  _default/      ->   Per-page templates (about, team, contact, ...), plus
                      list.html/taxonomy.html as generic fallbacks for any
                      section or tag/category page without a dedicated one.
  partials/      ->   Reusable partials + components/.
```

## Editing content

- **Pages** live in `content/` as Markdown with YAML/TOML front matter.
  Create a new page with `hugo new content content/<name>.md`.
- **Team members** are defined in [data/team.yaml](data/team.yaml).
- **Services** are defined in [data/services.yaml](data/services.yaml).
- **Navigation and footer menus** are configured in the `[menu]` section of
  [hugo.toml](hugo.toml).

## Publishing (production)

The production site is published to **GitHub Pages** and served at
**<https://t4eq.org>**.

Deployment is automated by
[.github/workflows/hugo.yml](.github/workflows/hugo.yml):

1. Open a pull request with your changes and get it reviewed.
2. Merge into the **`main`** branch.
3. On push to `main`, the workflow builds the site with `hugo --minify` and
   deploys it to GitHub Pages via `actions/deploy-pages`.

## Branch previews

Every branch pushed to this repo (other than `main`) is automatically built
and published at:

```
https://t4eq.org/preview/<branch-name>/
```

This is handled entirely by
[.github/workflows/hugo.yml](.github/workflows/hugo.yml):

- On every push to a non-`main` branch, the workflow builds the site with
  drafts enabled (`hugo -D`) and a `--baseURL` scoped to that branch's
  subpath, then publishes the result to the `<branch-name>/` directory of the
  separate **`T4EQ/preview`** repository (overwriting whatever 
  was there before).
- When a branch is deleted, the workflow removes its `<branch-name>/`
  directory from `T4EQ/preview`.

`T4EQ/preview` holds nothing but the built HTML/CSS/JS output 
for each active branch — it has no source files, no build logic, and no workflow 
of its own. GitHub Pages serves it directly (branch-based / legacy Pages source), 
so previews persist for as many branches as are currently open, with no manual
steps and no separate branch to maintain in this repo.

There's nothing to do locally to get a preview — just push your branch. To
test the exact preview build yourself before pushing:

```sh
HUGO_CANONIFYURLS=true nix develop --command hugo --minify -D \
  --baseURL "https://t4eq.org/preview/$(git branch --show-current)/" \
  --environment preview \
  --destination /tmp/preview-build
```

Publishing to `T4EQ/preview` requires the `PREVIEW_DEPLOY_KEY` 
repository secret (an SSH deploy key with write access to 
`T4EQ/preview`) to be configured on this repo.
