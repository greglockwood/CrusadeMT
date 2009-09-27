class Search < ActiveRecord::Base
  belongs_to :church

  has_many :search_involvements, :through => :search_involvement
  
  validates_presence_of :name, :on => :create, :message => "can't be blank"
  validates_uniqueness_of :name, :on => :create, :message => "must be unique"
  
  attr_accessor :based_on
  
  def criteria
    attributes.delete :id
  end
  
  def sql_conditions
    conditions = []
    values = []
    if first_name?
      conditions.push like(:first_name)
      values.push containing(first_name)
    end
    if nickname?
      conditions.push like(:nickname)
      values.push containing(nickname)
    end
    if last_name?
      conditions.push like(:last_name)
      values.push containing(last_name)
    end
    if suburb?
      conditions.push like(:suburb)
      values.push containing(suburb)
    end
    if gender?
      conditions.push like(:gender)
      values.push containing(gender)
    end
    if christian?
      conditions.push "christian = ?"
      values.push christian
    end
    #if became_christian?
    #  conditions.push "became_christian = ?"
    #  values.push became_christian
    #end
    # TODO Proper Became Christian at CCCA? search
    if min_age?
      conditions.push "(date_of_birth < ? OR IFNULL(age, -1) > ?)"
      values.push min_age.to_i.years.ago.to_date # prob not quite right, and I'm pretty sure there's an edge case or two not covered here
      values.push min_age.to_i
    end
    if max_age?
      conditions.push "(date_of_birth > ? OR IFNULL(age, 1000) < ?)"
      values.push max_age.to_i.years.ago.to_date # prob not quite right, and I'm pretty sure there's an edge case or two not covered here
      values.push max_age.to_i
    end
    # TODO Implement has_children search criteria
    # TODO Implement oldest_child_age search criteria
    if !church.nil?
      conditions.push "church_id = ?"
      values.push church_id
    end
    [conditions.join(" AND ")] + values
  end
  
  def to_param
    name
  end
  
private

  def like(field)
    "#{field.to_s} LIKE ?"
  end
  
  def containing(text)
    "%#{text}%"
  end
end
