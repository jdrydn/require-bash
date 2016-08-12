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

The quickest way to get this running is:

```
# Clone it from Github
$ git clone github.com:jdrydn/require-bash ~/.requireb
# And run it
$ ~/.requireb/requireb.sh --help
```

If you plan to use this often, add an alias to your `.shellrc` file:

```
# Create an alias in your .shellrc file
$ echo "alias requireb='~/.requireb/requireb.sh'" >> ~/.bashrc
# Reload your shell
$ source ~/.bashrc
# And try
$ requireb --help
```

You can always be sure that the MASTER branch of this repository contains a stable build. Any features or fixes will be worked on in a branch & merged in on completion.

There are also some unit-tests, written completely in Bash, which you are welcome to run with:

```
$ ./tests/run.sh
```

[Pull-requests are welcome](https://github.com/jdrydn/require-bash/pulls/), of course, and ideally should include some tests to specifically test the commit(s) in question. And if any bugs or problems arise [please open an issue](https://github.com/jdrydn/require-bash/issues/) :smile:
