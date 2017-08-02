module SaBountyHunter
  def email_string
    the_hit_array = []
    the_hit_hash = ten_most_wanted
    the_hit_hash.each do |target, owed|
      the_hit_array << "Name: #{target}, Amount Owed: $#{owed} \n"
    end
    the_hit_array.reduce(:+)
  end

  def email_body
    some_string = "Dear Mr. Dog, \n \n We here at the Umbrella Corp.
    , I mean Etsy, value our customers. However, while we understand that
    various circumstances may occur, we are unable to compromise in regards
    to our revenue stream. \n It's for the customers, you see.  If we don't
    have money to build our mansions, I mean pay our workers, we cannot
    possibly continue.  So while it may seem trivial, we believe it to be of
    upmost importance that our policy is 'understood' by all those who
    share in our Etsy Family. \n  We have a few individuals who we would
    like to extend a special offer, along with a reminder of how much Etsy
    values their patronage. \n  We believe you to have a particular set of
    skills, that make you ideally suited to extend these offers, on our
    behalf. \n \n  Please see below: \n "
    email_string
    another_string = "\n Please note, for each dear customer that chooses
    to accept our gracious offer, you will receive a 10% portion in
    recognition, of your hard work.  Thank you, and please, don't contact
    us directly, we'll contact you.
    \n \n Sincerely, \n The Etsy Family,\n
    We meet your catnip pillow needs \n"
    some_string + email_string + another_string
  end

  def write_file
    File.write('./test/file_test/special_offer.txt', email_body)
  end

end
