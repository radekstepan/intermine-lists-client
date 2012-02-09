coffee --compile --output test/ src/
cd src
find . -type d -exec mkdir -p ../test/{} \;
find . -type f -not \( -iname "*.coffee" \) -exec cp -rf {} ../test/{} \;