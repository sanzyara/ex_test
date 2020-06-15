# frozen_string_literal: true

require 'roda'
require 'forme'

require_relative 'models'

# comment
class TellApplication < Roda
  opts[:root] = __dir__
  plugin :environments
  plugin :forme
  plugin :render

  configure :development do
    plugin :public
    opts[:serve_static] = true
  end

  opts[:users] = UserList.new(
    [
      User.new(
        id: 1,
        name_one: 'Aleksandr',
        name_two: 'Volkov',
        number: 134333,
        rate: RateType::BEZLIM,
        min: 343
      ),
      User.new(
        id: 2,
        name_one: 'EVGEN',
        name_two: 'Ttes',
        number: 134567,
        rate: RateType::COMB,
        min: 55
      ),
      User.new(
        id: 3,
        name_one: 'Aleksandr',
        name_two: 'Volkov',
        number: 345134,
        rate: RateType::BEZLIM,
        min: 34343
      )
    ]
  )

  route do |r|
    r.public if opts[:serve_static]

    r.root do
      r.redirect '/list'
    end

    r.on 'list' do
      r.is do
        @parameters = DryResultFormeWrapper.new(FindNewSchema.call(r.params))
        @users = if @parameters.success?
                      #opts[:users].find_user(@parameters[:number],@parameters[:name_f])
                      opts[:users].ind_user(@parameters[:number],@parameters[:name_f])
        else
                      opts[:users].all_users.sort_by{|hsh| hsh[:rate]}
        end
        view('lists')
      end
    end



    r.on Integer do |user_id|
     
      @user = opts[:users].user_by_id(user_id)
        next if @user.nil?

      r.on 'delete' do
        r.get do
          @parameters = {}
          view('user_delete')
        end

        r.post do
            opts[:users].delete_user(@user.id)
            r.redirect('/list')
        end

      end


    end

    r.on 'statistic' do
      view('user_statistic')
    end

  
    

    r.on 'new' do
      r.get do
        view('new_user')
      end

      r.post do
        @parameters = DryResultFormeWrapper.new(UserNewSchema.call(r.params))
        if @parameters.success?
          opts[:users].add_user(@parameters)
          r.redirect '/list'
        else
          view('new_user')
        end
      end
    end
  end
end
