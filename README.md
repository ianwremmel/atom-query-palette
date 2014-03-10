# Query Palette package

Run queries against text data using `cmd-shift-j` in Atom.

## Supported Formats

> At this time, JSON is the only supported data format

### JSON

Query processing relies on [JSONPath](https://github.com/s3u/JSONPath). See that project for query examples.

## TODO

- [ ] Modularize to support other data types.
- [ ] Prevent pallete from opening for views with unsupported grammars.
- [ ] Replace JSONPath with something that
  1. More closely resembles XPath.
  2. Works.