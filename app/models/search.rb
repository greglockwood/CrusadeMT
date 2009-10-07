class Search < ActiveRecord::Base
  belongs_to :church

  has_many :search_involvements
  has_many :field_ministries, :through => :search_involvements
  
  validates_presence_of :name, :on => :create, :message => "can't be blank"
  validates_uniqueness_of :name, :on => :create, :message => "must be unique"
  
  attr_accessor :based_on
  
  
  
  def criteria
    attributes.reject { |key, value| key == 'created_at' || key == 'updated_at' || key == 'id' || key == 'name'}
  end
  
  def sql_conditions
    conditions = []
    values = []
    if first_name?
      conditions.push like("people.first_name")
      values.push containing(first_name)
    end
    if nickname?
      conditions.push like("people.nickname")
      values.push containing(nickname)
    end
    if last_name?
      conditions.push like("people.last_name")
      values.push containing(last_name)
    end
    if suburb?
      conditions.push like("people.suburb")
      values.push containing(suburb)
    end
    if gender?
      conditions.push like("people.gender")
      values.push containing(gender)
    end
    if christian?
      conditions.push "people.christian = ?"
      values.push christian
    end
    #if became_christian?
    #  conditions.push "became_christian = ?"
    #  values.push became_christian
    #end
    # TODO Proper Became Christian at CCCA? search
    if min_age?
      conditions.push "(people.date_of_birth < ? OR IFNULL(people.age, -1) > ?)"
      values.push min_age.to_i.years.ago.to_date # prob not quite right, and I'm pretty sure there's an edge case or two not covered here
      values.push min_age.to_i
    end
    if max_age?
      conditions.push "(people.date_of_birth > ? OR IFNULL(people.age, 1000) < ?)"
      values.push max_age.to_i.years.ago.to_date # prob not quite right, and I'm pretty sure there's an edge case or two not covered here
      values.push max_age.to_i
    end
    if !has_children.nil?
      conditions.push "(childrens_people.parent_id IS NOT NULL)" if has_children == true
      conditions.push "(childrens_people.parent_id IS NULL)" if has_children == false
    end
    # TODO Implement oldest_child_age search criteria
    if !church.nil?
      conditions.push "people.church_id = ?"
      values.push church_id
    end
    if !conditions.empty?
      [conditions.join(" AND ")] + values
    else
      [] # return an empty array if no conditions at all, rather than a [""] array
    end
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
