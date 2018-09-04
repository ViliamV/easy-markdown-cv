#!/bin/bash

indir="src/"
outdir="build/"
css_files=(icons normalize style print media)
css_path="./res/css/"
css_final="style.css"
template="--template=./res/template.html"
fonts="./res/fonts/"
images="img/"
filename="cv"
public_filename="index"

case $1 in
  debug)
    css_files+=(debug)
  ;;
  example)
    indir="example/"
    outdir="example_build/"
  ;;
  public)
    filename=$public_filename
    public="--variable=public"
esac

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

echo "running pandoc"
pandoc -s \
  --from=markdown+smart \
  --to=html5 \
  $public \
  -o $outdir/$filename.html \
  $indir/*.md \
  --css=${css_final} \
  $template

if [[ "$1" = "pdf" ]] || [[ "$1" = "example" ]]; then
  echo "running wkhtmltopdf"
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

if [[ "$1" = "example" ]]; then
  echo "running wkhtmltoimage"
  wkhtmltoimage \
    $outdir/$filename.html \
    $outdir/$filename.jpg
fi
exit
