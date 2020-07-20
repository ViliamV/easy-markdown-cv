#!/bin/bash

set -o errexit
# set -o nounset

HELP_REGEX='^(-h|--help)$'
colorprint() {
  # Prints in green color
  echo -e "\e[32m$1\e[39m"
}

if [[ -z "$1" ]]; then
  echo "Not enough arguments."
  exit 1
else
  # Prints help and exits if options include --help/-h
  if [[ "$1" =~ $HELP_REGEX ]]; then
    cat doc.txt
    exit
  elif [[ "$2" =~ $HELP_REGEX ]]; then
    case "$1" in
      public )
        echo "Creates html with variable public that hides contact info"
        ;;
      html )
        echo "Creates html without variable public"
        ;;
      pdf )
        echo "Creates pdf+jpg with variable pdfphoto if exists, should look like html version"
        ;;
      pdfbw )
        echo "Creates pdf+jpg without photo for black and white print"
        ;;
      pdfcolor )
        echo "Creates pdf+jpg with photo for color print"
        ;;
      debug )
        echo "Creates html with debug.css"
        ;;
    esac
    exit
  fi
fi

indir="/data/$CV_SOURCE/"
[[ ! -d "$indir" ]] && echo "Source directory $CV_SOURCE does not exists!" && exit 1
outdir="/data/$CV_OUTPUT/"

css_files=(fonts icons normalize style print media)
css_path="./res/css/"
css_final="style.css"
TEMPLATE="--template=./res/template.html"
fonts="./res/fonts/"
images="img/"
filename="cv"
public_filename="index"

case $1 in
  public)
    filename=$public_filename
    vars="--variable=public"
  ;;
  pdf)
    vars="--variable=usepdfphoto"
  ;;
  pdfbw)
    css_files+=(pdf_bw)
    filename+="_bw"
  ;;
  pdfcolor)
    css_files+=(pdf_color)
    filename+="_color"
  ;;
  debug)
    css_files+=(debug)
  ;;
esac

colorprint "Env:"
echo "input directory: $indir"
echo "output directory: $outdir"
echo -e "command: $1\n"

# create outdir
mkdir -p ${outdir}

# create css argument
css=""
for c in ${css_files[@]}; do
  css="${css} ${css_path}${c}.css"
done
cat ${css} > ${outdir}${css_final}

# copy fonts
cp -ru ${fonts} ${outdir} 2> /dev/null
# copy images
cp -ru ${indir}${images} ${outdir} 2> /dev/null

colorprint "Creating HTML"
pandoc -s \
  --from=markdown+smart \
  --to=html5 \
  $vars \
  -o $outdir/$filename.html \
  $indir*.yml \
  $indir*.md \
  --css=${css_final} \
  $TEMPLATE

if [[ "$1" = pdf* ]]; then
  colorprint "Converting to PDF"
  node topdf.js \
    $outdir/$filename.html \
    $outdir/$filename.pdf
  colorprint "Converting to JPEG"
  node tojpg.js \
    $outdir/$filename.html \
    $outdir/$filename.jpg
  # Cleanup
  loc=`pwd`
  cd $outdir
  rm -r fonts img *.html *.css
  cd $loc
fi

colorprint "Finished"
