coffee --compile --output js/ src/
cd src
find . -type d -exec mkdir -p ../js/{} \;
find . -type f -not \( -iname "*.coffee" \) -exec cp -rf {} ../js/{} \;