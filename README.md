## Setup

You need to have [**pandoc**](https://pandoc.org/) and [**wkhtmltopdf**](https://wkhtmltopdf.org/)
installed in order to create HTML (pandoc) and PDF (wkhtmltopdf) files.

## Start

- create directory `src` (directory name can be changed in `build.sh`)
    - alternatively copy `example` directory

          ```shell
          cp example src
          ```

- to that directory put markdown files that contain your CV, for example:

    ```shell
    ~ ls src
    01_basics.md      03_education.md     05_skills.md         07_interests.md
    02_experience.md  04_publications.md  06_side_projects.md  img/
    ```

    notice the directory `img`, it contains the profile photo.
- first file should contain header for pandoc that looks something like this

    ```yaml
     ---
     lang: en
     title: Résumé - Name Name
     firstname: Name
     lastname: Name
     photo: img/photo.jpg
     website: website.com
     email: Name@Name.com
     public-email: Name-public@Name.com
     mobile: '+420 000 000 000'
     address: Street 60, City, State
     github: Username
     gitlab: Username
     color: #ff0000
     ---
    ```

- that's it!

## Usage

Just run `make` or `./build.sh pdf && ./build.sh public` to create your CV.
Default build directory is `build`

## Features

### Header

configured in header file in `src/01_basics.md`
TODO: picture

### Sections

Sections are H2 headers.
Some of them have predefined icons, other icons can be added.

```markdown
  ## Experience
```
TODO: picture

### Two columns

Some items in CV look better in two columns.
For example Education and Experience.

```markdown
2016--2018
:   **Master's Degree**, *Some University*\
    City, State

```
TODO: picture

### Custom highlight color

configured in header file in `src/01_basics.md`
TODO: picture

### Force page break

```markdown
## Skills{.new-page}
```

## Example CV

![Example JPG](./example_build/cv.jpg)

[PDF](./example_build/cv.pdf)

[HTML](./example_build/cv.html)

[Live preview](https://viliamv.gitlab.io/easy-markdown-cv/)

## Icons
Icons by [Feather](https://github.com/feathericons/feather)
