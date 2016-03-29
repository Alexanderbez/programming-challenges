class Transaction < Hashie::Dash
  include Hashie::Extensions::Dash::PropertyTranslation
  include Hashie::Extensions::Dash::Coercion
  include Hashie::Extensions::Dash::IndifferentAccess
  include Hashie::Extensions::IgnoreUndeclared

  property :activity_id, required: true
  property :completed_at, from: :date, with: ->(v) { Time.parse(v) }
  property :display_date, from: :date, with: -> (v) { Time.parse(v).strftime('%m/%d/%y') }
  property :type, required: true, transform_with: ->(v) { v.capitalize }
  property :method
  property :amount, required: true
  property :balance, required: true
  property :requester, coerce: TransactionRequester
  property :source, required: true, coerce: TransactionSource
  property :destination, required: true, coerce: TransactionDestination

  # Builds a transaction description based upon the type, source, and
  # destination.
  # 
  # @return [String]
  def description
    @description ||= begin
      d = ''

      case self.type
      when 'Deposit'
        d += "Deposit from #{self.source.type.downcase} account #{self.source.description}"
      when 'Investment'
        d += "Investment in #{self.destination.description}"
      when 'Refund'
        d += "Refund from #{self.source.description}"
      when 'Withdrawal'
        d += "Withdrawal to #{self.destination.type.downcase} account #{self.destination.description}"
      when 'Transfer'
        d += "Transfer from #{self.source.type.downcase} #{self.source.description}"
      end

      d
    end
  end

end
