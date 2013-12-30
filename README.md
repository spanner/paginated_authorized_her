# PaginatedAuthorizedHer

This is a bit of extra stuff for the useful but annoyingly unfindable her gem. It supports token auth via an AUTHORIZATION header and pagination of the returned collection.

## Installation

Add this line to your application's Gemfile:

    gem 'paginated_authorized_her'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install paginated_authorized_her

## Pagination

Instead of 

    include Her::Model

use this instead:

    include PaginatedAuthorizedHer::Model

and make sure that your request middleware includes `PaginatedAuthorizedHer::Middleware::Parser`.


## Token auth

If your request middleware includes `PaginatedAuthorizedHer::Middleware::TokenAuth` then an AUTHORIZATION header will be added to all your API requests. 
It will contain the value of either `RequestStore.store[:auth_token]` or `RequestStore.store[:current_user].authentication_token`.

Your API definition will look something like this:

    DROOM = Her::API.new base_uri: "http://example.com/api" do |c|
      c.use Faraday::Request::UrlEncoded
      c.use PaginatedAuthorizedHer::Middleware::TokenAuth
      c.use PaginatedAuthorizedHer::Middleware::Parser
      c.use Faraday::Adapter::NetHttp
    end


## Configuration

We use Settingslogic and Requeststore. Your settings should include:



## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
