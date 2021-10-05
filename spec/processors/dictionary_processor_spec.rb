# frozen_string_literal: true

require './processors/dictionary_processor'

# rubocop:disable Metrics/BlockLength
RSpec.describe ::Processors::DictionaryProcessor do
  let(:file_path) { 'spec/fixtures/files/dictionary.txt' }
  let(:file_path_empty_file) { 'spec/fixtures/files/empty_dictionary.txt' }

  let(:target_words) { %w[convex tailor weaver] }

  subject(:filled_dictionary) do
    described_class.new(file_path: file_path)
  end

  subject(:empty_dictionary) do
    described_class.new(file_path: file_path_empty_file)
  end

  describe '#find_concatenated_words_via_hashes' do
    context 'when the dictionary is empty' do
      it 'returns result as nil' do
        expect(empty_dictionary.find_concatenated_words_via_hashes).to be(nil)
      end
    end

    context 'when the dictionary is filled' do
      it 'returns result with necessary words' do
        expect(filled_dictionary.find_concatenated_words_via_hashes).to include(*target_words)
      end
    end
  end

  describe '#find_concatenated_words_via_hashes_and_sets' do
    context 'when the dictionary is empty' do
      it 'returns result as nil' do
        expect(empty_dictionary.find_concatenated_words_via_hashes_and_sets).to be(nil)
      end
    end

    context 'when the dictionary is filled' do
      it 'returns result with necessary words' do
        expect(filled_dictionary.find_concatenated_words_via_hashes_and_sets).to include(*target_words)
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
