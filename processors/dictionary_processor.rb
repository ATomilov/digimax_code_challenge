module Processors
  class DictionaryProcessor
    attr_reader :prepared_data

    def initialize(file_path:)
      @file_path = file_path
      @prepared_data = {}
    end

    def find_concatenated_words
      prepare_data
      return if prepared_data.empty?

      prepared_data[REQUIRED_WORD_LENGTH]&.keys&.each_with_object([]) do |word, array|
        total_word_length = word.length
        current_word_substring = ''
        word.each_char do |char|
          current_word_substring << char
          target_first_word = prepared_data.dig(current_word_substring.length, current_word_substring)
          remain_word_length = total_word_length - current_word_substring.length
          remain_substring = word[(total_word_length - remain_word_length)..-1]

          break array << word if target_first_word && prepared_data.dig(remain_word_length, remain_substring)
        end
      end
    end

    private

    attr_reader :file_path

    REQUIRED_WORD_LENGTH = 6
    NEW_LINE_DELIMITER = "\n".freeze

    def prepare_data
      @prepare_data ||= File.foreach(file_path) do |line|
        formatted_string = line.delete(NEW_LINE_DELIMITER).downcase
        formatted_string_length = formatted_string.length
        prepared_data[formatted_string_length] ||= {}
        prepared_data[formatted_string_length][formatted_string] = 0
      end
    end
  end
end
