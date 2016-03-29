require 'spec_helper'

# --------------------------------------------------------------------------- #
#                               Request Helpers                               #
# --------------------------------------------------------------------------- #

describe BetterDoctor::V1 do
  before(:all) do
    @api_key = ENV['API_KEY']
  end

  it 'does not accept missing API key HTTP header' do
    # Perform request with missing API key HTTP header
    get '/api/v1/doctors/search'

    # Verify correct status code
    expect(response.status).to eq(401)

    # Verify response body
    expect(json['response_type']).to eq('error')
    expect(json['response']).to eq('Unauthorized')
  end

  it 'returns proper response for invalid API key HTTP header' do
    # Perform request with missing API key HTTP header
    get '/api/v1/doctors/search', headers: {'X-Api-Key' => 'nil'}

    # Verify correct status code
    expect(response.status).to eq(401)

    # Verify response body
    expect(json['response_type']).to eq('error')
    expect(json['response']['meta']['error']).to eq(true)
    expect(json['response']['meta']['message']).to eq('Invalid user_key')
    expect(json['response']['meta']['error_code']).to eq(1000)
  end

  it 'returns proper response for valid API key HTTP header' do
    # Verify API key validity
    expect(@api_key).to be_truthy

    # Perform request with API key HTTP header
    get '/api/v1/doctors/search', headers: {'X-Api-Key' => @api_key}

    # Verify correct status code
    expect(response).to be_success
  end

  it 'returns proper response for default proxy query' do
    # Perform request with API key HTTP header
    get '/api/v1/doctors/search', headers: {'X-Api-Key' => @api_key}

    # Verify correct status code
    expect(response).to be_success

    # Verify response body
    expect(json['meta']).not_to be_empty
    expect(json['data']).not_to be_empty
  end
end
