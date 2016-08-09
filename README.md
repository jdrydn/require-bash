# Require-Bash

A script to insert bash files into a base file, using a familiar require-like syntax.

## Usage

Take the following two scripts:

```
# functions.sh
function say_hello() {
  echo "Hello $1"
}

# input.sh
require "functions.sh"
say_hello "dude"
```

Running this file through this project will compile `functions.sh` at the point of `require "functions.sh"`. The result
can be piped into `bash` for immediate execution, or written to a file.

```
$ ./requireb.sh input.sh
#!/usr/bin/env bash

function say_hello() {
  echo "Hello $1"
}

say_hello "dude"
echo "Finished ^_^"

$ ./requireb.sh input.sh | bash
Hello dude
Finished ^_^

$ ./requireb.sh input.sh > output.sh
$ bash output.sh
Hello dude
Finished ^_^
```

## In your projects

```
# Pull down the require-bash project
$ git clone https://github.com/jdrydn/require-bash ~/require-bash
$ cd ~/path/to/my/project
$ ~/require-bash/requireb.sh input.sh > output.sh
$ bash output.sh
```

## Notes

- Questions? Awesome! [Open an issue](https://github.com/jdrydn/require-bash/issues/)
  [or a pull-request](https://github.com/jdrydn/require-bash/pulls/) to get started!
