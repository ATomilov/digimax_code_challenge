# frozen_string_literal: true

require 'benchmark/ips'
require './processors/dictionary_processor'

DICTIONARY_PATH = 'dictionaries/dictionary.txt'

processor = ::Processors::DictionaryProcessor.new(file_path: DICTIONARY_PATH)

Benchmark.ips do |x|
  x.report('find concatenated words via hash') { processor.find_concatenated_words_via_hashes }
  x.report('find concatenated words via hash and sets') { processor.find_concatenated_words_via_hashes_and_sets }
  x.compare!
end
