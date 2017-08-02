module SaBountyHunter
  def email_string
    the_hit_array = []
    the_hit_hash = ten_most_wanted
    the_hit_hash.each do |target, owed|
      the_hit_array << "name: #{target}, amnt owed: $#{owed} \n"
    end
    the_hit_array.reduce(:+)
  end

  def email_body
    some_string = "email intro \n"
    email_string
    another_string = "end of email \n"
    some_string + email_string + another_string
  end

  def write_file
    File.write('./test/file_test/special_offer.txt', email_body)
  end

end
