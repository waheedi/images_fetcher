## images_fetcher
ImageFetcher helps you to fetch images from a list of URIs


#### Usage

##### Running ImageFetcher
`$ image_fetcher -s test/fixtures/source_images.txt -v`

`$ image_fetcher -h`

```
Usage: image_fetcher [options]

ImageFetcher options:
    -s, --source FILE                Source file/URI to be used as source for image fetcher
    -f, --format FORMAT              Source file format type (default: "plain")
                                     (plain, json, html, xml, yml)
        --delay N                    Delay N seconds before executing
    -t, --time [TIME]                Begin execution at given time
    -v, --verbose                    Run verbosely

Common options:
    -h, --help                       Show this message
        --version                    Show version
```

##### Testing
Test coverage 30%
`$ rspec test/unit/* --format documentation`


