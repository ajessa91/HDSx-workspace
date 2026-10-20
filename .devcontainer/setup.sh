#!/usr/bin/env bash
# -----------------------------------------------------------------------------
# SPPH 381H student-workspace Codespace post-create setup.
#
# Installs the few packages NOT already in the rocker tidyverse image, then
# runs a self-test so you can see at a glance what works. We deliberately do
# NOT use `set -e`: if one optional package fails, the rest of setup should
# still finish and the self-test should still print, so the failure is visible
# instead of silently aborting the whole container build.
# -----------------------------------------------------------------------------
set -uo pipefail

echo "==> Installing extra R packages (Table 1, dashboards, optional demos)..."
Rscript -e '
  pkgs <- c("gt", "gtsummary", "DT", "janitor", "scales", "plotly", "shiny", "reticulate")
  need <- setdiff(pkgs, rownames(installed.packages()))
  if (length(need)) install.packages(need, repos = "https://cloud.r-project.org")
  have <- intersect(pkgs, rownames(installed.packages()))
  cat("R extras present:", paste(have, collapse = ", "), "\n")
'

# 🤖 AI edit (Claude), 2026-09-29, revised 2026-10-20: this block and the sess
# self-test line.
# sess connects R terminals to the VS Code R extension, which is how plots and
# View() reach the editor. vscode-R 3.2+ accepts only the sess built from its own
# release. Any other copy gets an easily missed "Install bundled sess" pop-up,
# and until someone clicks it, plots silently go to Rplots.pdf. r-universe builds
# from vscode-R's main branch, which drifts from the release, so install the copy
# inside the pinned release file. When bumping "REditorSupport.r@..." in
# devcontainer.json, bump VSCODE_R_VERSION and its checksum (sha256sum of the
# release's r-<version>.vsix) here too.
export VSCODE_R_VERSION=3.2.0
export VSCODE_R_SHA256=fbfd1dad22c5ab696750d201d4732ce30c032f22265d4efe2b220eb4361efd1e
echo "==> Installing sess from vscode-R ${VSCODE_R_VERSION} (sends plots from R to VS Code)..."
Rscript -e '
  version <- Sys.getenv("VSCODE_R_VERSION")
  vsix <- tempfile(fileext = ".vsix")
  download.file(sprintf("https://github.com/REditorSupport/vscode-R/releases/download/v%s/r-%s.vsix",
                        version, version), vsix, mode = "wb", quiet = TRUE)
  stopifnot("vscode-R release file failed its checksum" =
              tools::sha256sum(vsix) == Sys.getenv("VSCODE_R_SHA256"))
  bundled <- "extension/dist/resources/sess/"
  unzip(vsix, files = grep(paste0("^", bundled), unzip(vsix, list = TRUE)$Name, value = TRUE),
        exdir = tempdir())
  pkg <- file.path(tempdir(), bundled)
  imports <- strsplit(read.dcf(file.path(pkg, "DESCRIPTION"), "Imports"), ",")[[1]]
  need <- setdiff(trimws(sub("[(].*", "", imports)), rownames(installed.packages()))
  if (length(need)) install.packages(need, repos = "https://cloud.r-project.org")
  install.packages(pkg, repos = NULL, type = "source")
'

echo "==> Installing Python packages (Week 5 polyglot / reticulate demo)..."
python3 -m pip install --upgrade pip >/dev/null
python3 -m pip install -r .devcontainer/requirements.txt

echo ""
echo "=================== TOOLCHAIN SELF-TEST ==================="
echo "-- R --";       R --version | head -n 1
echo "-- Quarto --";  quarto --version
echo "-- Python --";  python3 --version
echo "-- pandas --";  python3 -c "import pandas as pd; print('pandas', pd.__version__)" || echo "pandas NOT available"
echo "-- sess --";    Rscript -e 'cat("sess", format(packageVersion("sess")), packageDescription("sess", fields = "Config/vscode-R/source-revision"), "\n")' 2>/dev/null || echo "sess NOT available (plots will not show in VS Code)"
echo ""
echo "-- quarto check (verifies R + Python + Jupyter integration) --"
quarto check || true
echo "=========================================================="
echo "If every section above printed a version with no error, the"
echo "environment is ready. If something failed, copy this whole log"
echo "and send it to the instructor so it can be fixed."
