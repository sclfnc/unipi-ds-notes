# ============================================================
# Canonical latexmk config — identical in every course folder.
# All output (main.pdf and every auxiliary: .aux/.log/.toc/.bcf/.bbl/...)
# lands in the folder root. The auxiliaries are git-ignored (see .gitignore).
#   Build:  latexmk        (from the folder root)
#   Clean:  latexmk -c     (remove aux)   |   latexmk -C  (also remove pdf)
# ============================================================

$pdf_mode = 1;             # pdflatex
$out_dir  = '.';           # everything (pdf + auxiliaries) in the folder root
$bibtex_use = 2;           # run biber/bibtex as needed, incl. on clean
$force_mode = 1;           # keep running all passes even if a pass exits non-zero
                           # (sds has known stray-\\ content errors; lds has a
                           #  listings quirk — both must still get full ToC/ref passes)

# Non-interactive.
set_tex_cmds('-interaction=nonstopmode %O %S');

# Extra files latexmk should also delete on -c / -C.
$clean_ext = 'bbl run.xml synctex.gz synctex(busy) nav snm vrb';
