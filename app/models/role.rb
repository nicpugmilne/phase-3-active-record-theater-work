class Role < ActiveRecord::Base
  has_many :auditions

  def actors
    self.auditions.map { |audition| audition.actor }
  end

  def locations
    self.auditions.map { |audition| audition.location }
  end

  # Find returns the first match by default, if there are no matches then the else clause is served

  def lead
    if self.auditions.find { |a| a.hired == true } != nil
      return self.auditions.find { |a| a.hired == true }
    else
      "no actor has been hired for this role"
    end
  end

  # Requires a method that returns an array of all items that match the condition, so that the second item can be selected. If there are less than 2 items in the returned array, then no understudy has been hired

  def understudy
    hired_actors = self.auditions.select { |a| a.hired == true }
    if hired_actors.size < 2
      "no actor has been hired for understudy for this role"
    else
      hired_actors[1]
    end
  end
end
