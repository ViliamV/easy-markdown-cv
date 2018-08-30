#!/bin/bash

indir="src/"
outdir="build/"
css_files=(fonts icons normalize style print media)
css_path="./css/"
css_final="style.css"
fonts="fonts/"
images="img/"

template="--template=./template/template.html"

case $1 in
  debug)
    css_files+=(debug)
  ;;
  example)
    indir="example/"
    outdir="example_build/"
    css_path="./css/"
  ;;
esac

# create css argument
css=""
for c in ${css_files[@]}; do
  css="${css} ${css_path}${c}.css"
done
cat ${css} > ${outdir}${css_final}

# copy fonts
cp -ru ${fonts} ${outdir}
# copy images
cp -ru ${indir}${images} ${outdir} 2> /dev/null

echo "running pandoc"
pandoc -s \
  --from=markdown+smart \
  --to=html5 \
  -o $outdir/cv.html \
  $indir/*.md \
  --css=${css_final} \
  $template

if [[ "$1" = "pdf" ]] || [[ "$1" = "example" ]]; then
  echo "running wkhtmltopdf"
  wkhtmltopdf \
    --print-media-type \
    --orientation Portrait \
    --page-size A4 \
    --margin-top 15 \
    --margin-left 25 \
    --margin-right 25 \
    --margin-bottom 15 \
    $outdir/cv.html \
    $outdir/cv.pdf
fi

if [[ "$1" = "example" ]]; then
  echo "running wkhtmltoimage"
  wkhtmltoimage \
    $outdir/cv.html \
    $outdir/cv.jpg
fi
exit
