class TransactionSource < Hashie::Dash
  include Hashie::Extensions::Dash::IndifferentAccess
  include Hashie::Extensions::IgnoreUndeclared
  
  property :type
  property :id
  property :description
end
