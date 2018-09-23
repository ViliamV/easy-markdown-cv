#!/bin/bash

# usage:
# build html - html without variable public
# build pdf - pdf with variable pdfphoto if exists
# build bwpdf - pdf without photo for black and white print
# build public - html with variable public that hides contact info
# build debug - html with debug.css
# build example - example html+pdf

function colorprint {
  echo -e "\e[32m$1\e[39m"
}


if [ -z "$1" ]; then
  echo "Not enough arguments."
  exit 1
fi

if [ -n "$CV_INDIR" ]; then
  indir="$CV_INDIR"
else
  indir="src/"
fi
if [ -n "$CV_OUTDIR" ]; then
  outdir="$CV_OUTDIR"
else
  outdir="build/"
fi
css_files=(icons normalize style print media)
css_path="./res/css/"
css_final="style.css"
template="--template=./res/template.html"
fonts="./res/fonts/"
images="img/"
filename="cv"
public_filename="index"

case $1 in
  html)
    outdir+="html/"
  ;;
  pdf)
    vars="--variable=usepdfphoto"
    outdir+="pdf/"
  ;;
  bwpdf)
    css_files+=(bw)
    outdir+="pdf/"
    filename+="_bw"
  ;;
  public)
    filename=$public_filename
    vars="--variable=public"
    outdir+="public/"
  ;;
  debug)
    css_files+=(debug)
    outdir+="html/"
  ;;
  example)
    indir="example/"
    outdir="example_build/"
  ;;
  examplebwpdf)
    indir="example/"
    outdir="example_build/"
    css_files+=(bw)
    filename+="_bw"
esac

colorprint "Env:"
echo "input directory: $indir"
echo "output directory: $outdir"
echo "command: $1"
echo

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

colorprint "Running pandoc"
pandoc -s \
  --from=markdown+smart \
  --to=html5 \
  $vars \
  -o $outdir/$filename.html \
  $indir/*.md \
  --css=${css_final} \
  $template

if [[ "$1" = *pdf ]] || [[ "$1" = example* ]]; then
  colorprint "Running wkhtmltopdf"
  wkhtmltopdf \
    --orientation Portrait \
    --page-size A4 \
    --margin-top 15 \
    --margin-left 15 \
    --margin-right 15 \
    --margin-bottom 15 \
    $outdir/$filename.html \
    $outdir/$filename.pdf
fi

if [[ "$1" = *pdf ]]; then
  loc=`pwd`
  cd $outdir
  (GLOBIGNORE='*.pdf'; rm -r *)
  cd $loc
fi

if [[ "$1" = "example" ]]; then
  colorprint "Running wkhtmltoimage"
  wkhtmltoimage \
    $outdir/$filename.html \
    $outdir/$filename.jpg
fi

colorprint "Finished"
