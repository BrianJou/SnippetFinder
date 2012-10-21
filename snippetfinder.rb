OPINIONS = ["good", "great", "satisfactory", "acceptable", "solid", "superb",
            "excellent", "better", "best", "fantastic", "psoitive", "perfect",
            "bad", "awful", "worse", "worst", "inferior", "crappy", "mean", "love",
            "loves", "loved", "hate", "hated", "hates", "avoid", "avoided", "avoids"]

def main(args)
  #Takes in snippet in the form of <doc> <query>
  #Ignore any other options..
  doc = ARGV[0]
  query = ARGV[1]

  sentences = split_into_sentences(doc)
  words = split_into_words(query)

  rankedsentences = rank_sentence(sentence)
  rankedsentences.sort_by { |a, b| a[0] <=> b[0] }
  puts rankedsentences[0]
end

def split_into_sentence(content)
  #Split into sentences, assume those tweeners use excessive !?!? to append their sentences
  sentences = content.split(/[\.\?\!]+\s[A-Z\d]/)
end

def split_into_words(content)
  words = content.split(' ')
end

def rank_sentence(content, query)
  #Lets rank the sentences as so,
  #+1 point for having the word in the sentence
  #+3 points for having an opiniated in the sentence
  ranked_sentences = []
  content.each do |sentence|
    points = opinions.map{|word| sentence.count(word) * 3}.inject(0, :+)
    points += query.map{|word| sentence.count(word)}.inject(0, :+)
    ranked_sentences.push([points, sentence])
  end
end

main(ARGV)
