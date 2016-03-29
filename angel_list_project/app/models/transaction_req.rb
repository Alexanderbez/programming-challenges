class TransactionRequester < Hashie::Dash
  include Hashie::Extensions::Dash::IndifferentAccess
  include Hashie::Extensions::IgnoreUndeclared

  property :type
end
