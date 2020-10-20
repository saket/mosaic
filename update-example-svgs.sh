#!/usr/bin/env bash

set -e

REPO_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# Ensure example binaries are available
"$REPO_DIR/gradlew" -q --console plain -p "$REPO_DIR" installDist

for example in examples/*/; do
	example_name=$(basename "$example")
	echo "Capturing $example..."
	svg-term --command="'$example/build/install/$example_name/bin/$example_name' && sleep 2 && echo" --out="$example/demo.svg" --from=50 --window --width=50 --height=16 --no-cursor
	cat > "$example/README.md" <<EOL
# Example: $example_name

<img src="demo.svg">
EOL
done

echo "Done"
