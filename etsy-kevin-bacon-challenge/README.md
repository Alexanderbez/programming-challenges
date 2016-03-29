# Kevin Bacon Etsy Challenge

"Using these files as a reference, in any language, build a command line program in which you enter the name of an actor or actress and output the steps to get to Kevin Bacon via Nth degree co-stars."

The output will be in the following format:

```
"actor/actress <(movie)> actor/actress <(movie)> ... Kevin Bacon"
```

## Preliminary

* Running Ruby v1.9.3+
* Bundler installed

```shell
$ cd etsy-kevin-bacon-challenge && bundle install
```

The underlying implementation is a bidirectional cyclical graph built using an adjacency list (Hash of Hashes).

Example:

```json
{
  "Denzel Washington": {
    "Kevin Bacon": [
      "Movie A",
      "Movie B"
    ],
    "Olivia Wilde": [
      "Movie C"
    ]
  },
  "Kevin Bacon": {
    "Denzel Washington": [
      "Movie A",
      "Movie B"
    ]
  },
  "Olivia Wilde": {
    "Denzel Washington": [
      "Movie C"
    ]
  }
}
```

## Tests

I have written a series of unit tests that cover testing of size, search, and structure.

To run the unit tests:

```shell
$ bundle exec rake test
```

## CLI Tool

A CLI tool is written wrapping the core implementation.

```shell
$ bundle exec bin/kb --help
Usage: kb [options]
    -n, --name <actor|actress>       Actor or actress to get to Kevin Bacon via Nth degree co-stars
    -p, --input-path <path>          Input path representing film data
    -h, --help                       Display this help
```

Example:

```shell
$ bundle exec bin/kb -n "Olivia Wilde" -p data/films
Olivia Wilde <(The Incredible Burt Wonderstone)> Steve Carell <(Crazy, Stupid, Love.)> Kevin Bacon
```

## Usage

You can also use an executable console to test and use the graph implementation directly:

```shell
$ bundle exec bin/console
pry(main)> empty_graph = KevinBacon::Graph.build
pry(main)> graph_with_data = KevinBacon::Graph.build('/some/absolute/path/to/films')
pry(main)> empty_graph.size
=> 0
```

## Notes

- Finding the steps to get to Kevin Bacon via Nth degree co-stars is implementated using BFS. The reason I chose BFS is due to the fact that it is likely that an actor or actress is not too far from Kevin Bacon due the relatively small amount of actors and actresses in the set provided and even in general. In other words, the graph will not be too nested or deep for a particular actor or actress. BFS, in most, if not all, cases will out perform DFS.

