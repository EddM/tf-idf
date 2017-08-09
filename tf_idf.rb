# term frequency
def tf(term, document)
  document_size = document.size
  frequency = document.count(term)

  frequency.to_f / document_size.to_f
end

# inverse document frequency
def idf(term, corpus)
  corpus_size = corpus.size

  documents_containing_term = corpus.count do |document|
    document.include?(term)
  end

  Math.log(corpus_size.to_f / documents_containing_term.to_f, 10)
end

def tfidf(term, document, corpus)
  tf(term, document) * idf(term, corpus)
end

require "minitest/autorun"

class TestTfIdf < Minitest::Test
  def setup
    @corpus = [
      %w(the quick brown fox and the quirky black frog jumped over the lazy dog),
      %w(the stars are beautiful tonight),
      %w(the itchy and scratchy show)
    ]
  end

  def test_calculates_word_importance
    assert_in_delta 0.034, tfidf("brown", @corpus[0], @corpus), 0.001
  end

  def test_inversely_weighs_common_words
    assert_equal 0, tfidf("the", @corpus[0], @corpus)
  end
end
