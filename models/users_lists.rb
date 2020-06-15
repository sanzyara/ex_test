# frozen_string_literal: true

require_relative 'user'
require_relative 'rate_type'

# Some comment
class UserList


  def initialize(users = [])
    @users = users.map do |user|
      [user.id, user]
    end.to_h
  end

  def all_users
    @users.values
  end

  def user_by_id(id)
    @users[id]
  end

  def add_user(parameters)
    max_id = @users.keys.max + 1
    @users[max_id] = User.new(
      id: max_id,
      name_one: parameters[:name_one],
      name_two: parameters[:name_two],
      number: Random.rand(100000..1000000),
      rate: parameters[:rate],
      min: 0
    )
  end


  def delete_user(id)
    @users.delete(id)
  end


  def self.ind_user(numb_f,name_f)
    

    @users.select do |key,user|
      next if numb_f && numb_f != user[:number]
      next if name_f && !name_f.empty? && !user[:name_two].include?(name_f)

      true
    end
  end



end
