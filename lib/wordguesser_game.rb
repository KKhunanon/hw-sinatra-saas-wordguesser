class WordGuesserGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/wordguesser_game_spec.rb pass.

  # Get a word from remote "random word" service

  def initialize(word)
    @word = word  #global val = @ 
    @guesses = ''
    @wrong_guesses = ''
    @show =""   #display
    @try = 0

    word.length.times do @show += "-" end

  end

  def word ()
    @word
  end

  def guesses() #
    @guesses
  end

  def guess(input_guesses) # Check our al
    #input scaning
    raise ArgumentError.new("nil str err") if input_guesses == nil
    raise ArgumentError.new("empty str err") if input_guesses.length == 0 
    raise ArgumentError.new("no letter err") if !(input_guesses.match?(/\A[a-zA-Z]+\z/))
    input_guesses.downcase!


    if @word.include?(input_guesses)
      if @guesses.include?(input_guesses)
        return false
      else
        i = 0
        word.length.times do
          if word[i] == input_guesses 
            @show[i] = input_guesses
          end
          i+=1
        end
        @guesses = input_guesses 
      end
    else
      if @wrong_guesses.include?(input_guesses)
        return false
      else
        @wrong_guesses = input_guesses 
      end
    end
    @try += 1
    
  end

  def wrong_guesses ()
    @wrong_guesses
    
  end

  def word_with_guesses()
      @show
  end

  def check_win_or_lose()
    if @try >= 7 
      return :lose
    elsif @word == @show
      return :win 
    else
      return :play
    end
  end


  # You can test it by installing irb via $ gem install irb
  # and then running $ irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> WordGuesserGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://randomword.saasbook.info/RandomWord')
    Net::HTTP.new('randomword.saasbook.info').start { |http|
      return http.post(uri, "").body
    }
  end

end
