## Setup

You need to have [**pandoc**](https://pandoc.org/) and [**wkhtmltopdf**](https://wkhtmltopdf.org/)
installed in order to create HTML (pandoc) and PDF (wkhtmltopdf) files.

Great benefit is that you don't need to have LaTeX installed in order to produce PDF.

## Start

- create directory `src` (directory name can be changed in `build.sh`)
    - alternatively copy `example` directory

    ```shell
    cp -r example/ src/
    ```

- to that directory put markdown files that contain your CV, for example:

    ```shell
    ~ ls src
    01_basics.yml     03_education.md     05_skills.md         07_interests.md
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
     pdfphoto: img/photo_pdf.jpg
     website: website.com
     email: Name@Name.com
     public-email: Name-public@Name.com
     mobile: '+420 000 000 000'
     address: Street 60, City, State
     github: Username
     gitlab: Username
     linkedin: Username
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

### Black&White PDF for printing
[Link here](./output/pdf/cv_bw.pdf)

## Example CV

![Example JPG](./output/pdf/cv.jpg)

[PDF](./output/pdf/cv.pdf)

[HTML](./output/publiv/index.html)

[Live preview](https://viliamv.gitlab.io/easy-markdown-cv/) TODO!

## Icons
Icons by [Feather](https://github.com/feathericons/feather)

Inspiration - [Pandoc ModernCV](https://github.com/barraq/pandoc-moderncv)
