$:.unshift(File.dirname(__FILE__))

require 'sinatra'
require 'haml'
require 'json'
require 'app/models'

# --------------------------------------------------------------------------- #
#                               Sinatra Helpers                               #
# --------------------------------------------------------------------------- #

helpers do

  # Sanitizes a collection of ledger transactions received from a fake API
  # response.
  #
  # @param ledger_name [String]
  # @return [Array]
  def sanitize_ledger(ledger_name)
    data_file   = File.read("data/#{ledger_name}.json")
    ledger_data = JSON.parse(data_file)

    raise 'No data' unless ledger_data

    @transactions = ledger_data.collect { |t| Transaction.new(t) }

    # Filter out dups
    @transactions.uniq! { |t| t.activity_id }

    # Sort by transaction date
    @transactions.sort_by! { |t| t.completed_at }

    # Handle transactions that occured at the same time but are out of order
    dups = @transactions.group_by { |t| t.completed_at }

    dups.each do |time, sub_t|
      t_len = sub_t.length

      if t_len > 1
        i = @transactions.index(sub_t.first)

        if (i - 1) >= 0
          past = @transactions[i - 1]

          t_len.times do |_|
            corr_t = sub_t.find { |t| past.balance + t.amount == t.balance }

            if corr_t
              j = @transactions.index(corr_t)

              # Swap
              @transactions[i], @transactions[j] = @transactions[j], @transactions[i]

              # Update correct past transaction
              past = @transactions[i]
              i += 1
            end
          end
        end
      end
    end

    # Reverse in order to display transactions in descending order
    @transactions.reverse!
  end
  
end

# --------------------------------------------------------------------------- #
#                                Sinatra Routes                               #
# --------------------------------------------------------------------------- #

# Displays the Ledger Lunacy README file.
get '/' do
  content_type 'text/plain'
  File.read('README.md')
end

# Displays a ledger for an investment account.
get '/:ledger_name' do
  # Sanitize ledger transactions (fake API response) before displaying
  sanitize_ledger(params[:ledger_name])
  haml :ledger
end
