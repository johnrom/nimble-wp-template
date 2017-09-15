# copy folders
cp -R "$template_dir"/_conf "$www_dir"
cp -R "$template_dir"/.vscode "$www_dir"

# ignore project directories
cp "$template_dir"/.gitignore.dist "$www_dir"/.gitignore
