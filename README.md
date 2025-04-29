# T4EQ.github.io

## About the project

This repository holds the sources of the [t4eq.github.io](https://t4eq.github.io) website. 
The website is built with [Hugo](https://gohugo.io/) using a set of resources written in 
[markdown](https://www.markdownguide.org/).

## Getting started

Clone the repository with:

```sh
git clone --recurse-submodules git@github.com:T4EQ/T4EQ.github.io.git 
```

This will create a `T4EQ.github.io` directory inside your current working directory.
The layout of this directory is as follows: 

```
.
├── README.md           -> This file. Contains information about the project.
├── hugo.toml           -> Configuration file for Hugo.
├── content             -> All the content of the website. Contains the markdown sources.
│   ├── _index.md       -> Index page of the website, shown when you visit T4EQ.github.io.
│   ├── about.md        -> About page.
│   └── contact.md      -> Contact page.
├── archetypes         
│   └── default.md      -> Default skeleton used for all new content created with Hugo.
├── themes              
│   └── ananke          -> The theme used for the website
├── flake.nix           -> Declares the dependencies of the repo in order to perform reproducible web builds. You can safely ignore this file.
└── flake.lock          -> Pins the dependencies of the repository. You can safely ignore this file.
```

For detailed instructions of how to use Hugo see its [Documentation](https://gohugo.io/documentation/) page.

### Dependencies

This website relies on the following software:
- `Hugo`, `v0.136.5`. You can find prebuilt binaries for most target operating systems and CPU architectures 
  [here](https://github.com/gohugoio/hugo/releases/tag/v0.136.5).
- _Optional:_ `Nix` package manager. See download instructions [here](https://nixos.org/download/).

The `Nix` package manager is used to ensure that the build results are fully reproducible accross 
all machines. When using `Nix`, you don't need to worry about installing `Hugo` separately. It is mostly
intended for continuous integration/deployment in GitHub, so you may decide to skip its installation 
for your development setup.

### Build with Hugo

To build the website simply run:

```sh
hugo
```

A `public` directory will be created, which contains the static content of the built website. You can open
`index.html` in a web browser to view the website locally.

Alternatively, you can serve the website locally on port `1313` using:

```sh
hugo serve
```

Note that this command does not terminate. Instead, it watches all file changes to the content of 
the website and automatically rebuilds the contents when they change, so that simply refreshing the 
web browser page displays the latest edits. The web page is accessible in `http://localhost:1313`

### Build with Nix

As mentioned above, this setup is mainly intended for continuous integration/deployment. However, 
if you have the `Nix` package manager installed in your system, it will automatically ensure you 
get the right `Hugo` version out of the box.

You can build the website with:

```sh
nix build --extra-experimental-features 'nix-command flakes' .
```

And find the result under the `result` directory.

Or you can enter a development shell with the full environment preconfigured and run the build steps 
listed in [Build with Hugo](#build-with-hugo), using:

```sh
nix develop --extra-experimental-features 'nix-command flakes' .
```

See [direnv](https://direnv.net/) to automatically execute `nix develop` when you change your working directory
to a subdirectory inside this repository.

## Making content changes

### Adding a new page

- Create a new file inside the `content` directory with the name of the page. You can do this with 
hugo using `hugo new content content/${MY_NEW_FILE}.md`, which has the benefits of automatically applying 
the default archetype.
- Edit the content of the new file using markdown.

### Submitting and deploying website changes

Ideally, the content of the website should be reviewed by another team member before it is deployed to 
[t4eq.github.io](https://t4eq.github.io). This is enforced using [GitHub Pull Requests](https://docs.github.com/es/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/about-pull-requests):
- Create a branch in the repository.
- Make your changes locally, making sure to build them and check them out following the steps in [Build with Hugo](#build-with-hugo).
- Once you are satisfied with the changes, create a new git commit.
- Push the branch to github and open a pull request targetting the `main` branch. 
- Assign a teammate as a reviewer of the changes, and make sure that the automated CI build passed.
- If any changes are requested, or if the CI build did not pass, amend the changes locally, and push them to GitHub.
- Once approved, merge the pull request.
- When the changes are merged in the `main` branch, they are automatically deployed to [Build with Hugo](#build-with-hugo).

### What about other kind of changes to the website? 

Have a look at `Hugo`'s [documentation](https://gohugo.io/documentation/). It is pretty extensive, 
you can pretty much change anything you like. Or ask Javier, he might even be able to help (hopefully).
