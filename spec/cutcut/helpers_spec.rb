require 'spec_helper'

describe CutCut::Helpers do
  it 'return longest comon string' do
    expect(CutCut::Helpers.longest_common_substring('foobar', 'foo')).to eq('foo')
  end
end
