# PaginatedHer

This is a bit of extra stuff for the useful but annoyingly unfindable [Her](https://github.com/remiprev/her).
In this newly simplified version all we do is extract pagination metadata in response to the calls that kaminari will make.
We do this quite crudely, by monkey-patching Her::Collection. This gem only exists to avoid duplication in our API client libraries.

## Requirements

Her.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
