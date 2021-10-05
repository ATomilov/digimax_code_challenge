require 'set'

module Processors
  # Service to find all six-letter words that are built of two concatenated smaller words
  class DictionaryProcessor
    attr_reader(*%i[prepared_data_hashes prepared_data_sets])

    def initialize(file_path:)
      @file_path = file_path
      @prepared_data_hashes = {}
      @prepared_data_sets = {}
    end

    def find_concatenated_words_via_hashes
      prepare_hash_data
      return if prepared_data_hashes.empty?

      find_word_in_hashes
    end

    def find_concatenated_words_via_hashes_and_sets
      prepare_hash_and_sets_data
      return if prepared_data_sets.empty?

      find_word_in_sets
    end

    private

    attr_reader :file_path

    REQUIRED_WORD_LENGTH = 6
    NEW_LINE_DELIMITER = "\n".freeze

    # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    def find_word_in_hashes
      prepared_data_hashes[REQUIRED_WORD_LENGTH]&.keys&.each_with_object([]) do |word, array|
        total_word_length = word.length
        current_word_substring = ''
        word.each_char do |char|
          current_word_substring << char
          target_first_word = prepared_data_hashes.dig(current_word_substring.length, current_word_substring)
          remain_word_length = total_word_length - current_word_substring.length
          remain_substring = word[(total_word_length - remain_word_length)..-1]

          break array << word if target_first_word && prepared_data_hashes.dig(remain_word_length, remain_substring)
        end
      end
    end
    # rubocop:enable Metrics/AbcSize, Metrics/MethodLength

    # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    def find_word_in_sets
      prepared_data_sets[REQUIRED_WORD_LENGTH]&.each_with_object([]) do |word, array|
        total_word_length = word.length
        current_word_substring = ''
        word.each_char do |char|
          current_word_substring << char
          target_first_word = prepared_data_sets[current_word_substring.length].include?(current_word_substring)
          remain_word_length = total_word_length - current_word_substring.length
          remain_substring = word[(total_word_length - remain_word_length)..-1]

          break array << word if target_first_word && prepared_data_sets[remain_word_length]&.include?(remain_substring)
        end
      end
    end
    # rubocop:enable Metrics/AbcSize, Metrics/MethodLength

    def prepare_hash_data
      @prepare_hash_data ||= File.foreach(file_path) do |line|
        formatted_string = line.delete(NEW_LINE_DELIMITER).downcase
        formatted_string_length = formatted_string.length
        prepared_data_hashes[formatted_string_length] ||= {}
        prepared_data_hashes[formatted_string_length][formatted_string] = 0
      end
    end

    def prepare_hash_and_sets_data
      @prepare_hash_and_sets_data ||= File.foreach(file_path) do |line|
        formatted_string = line.chomp.downcase
        formatted_string_length = formatted_string.length
        prepared_data_sets[formatted_string_length] ||= ::Set.new
        prepared_data_sets[formatted_string_length] << formatted_string
      end
    end
  end
end
