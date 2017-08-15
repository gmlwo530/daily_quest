class HomeController < ApplicationController
  before_action :authenticate_user!
  def makeQuest_new
    @user = current_user
  #  if @user.status == 1
  #     redirect_to '/makeQuest_quest'
  #  end
  
    time = Time.new
    time_day = time.day
    
    temp1 = (@user.id + time_day) % 8 + 1
    temp2 = temp1 % 13 + 9
    temp3 = (temp1 + 8) % 11 + 22
    temp4 = (temp1 + 21) % 3 + 33
    temp5 = (temp1 + 32) % 5 + 36
    
    @quest1 = Quest.find_by(id: temp1)
    @quest2 = Quest.find_by(id: temp2)
    @quest3 = Quest.find_by(id: temp3)
    @quest4 = Quest.find_by(id: temp4)
    @quest5 = Quest.find_by(id: temp5)
    
  end
  
  def selectQuest   # makeQeust_user창에서 퀘스트를 발급 받으면 사용자와 퀘스트 간에의 관계를 묶어 주는 메소드입
    user = current_user
    user.update(status: true)
    
    
    @userquest = Userquest.create(user_id: params[:user_id], quest_id: params[:quest_id], success: '2')
    redirect_to '/makeQuest_quest'
  
  end

  def makeQuest_quest
   
    @user = current_user
    @userquest = Userquest.find_by(user_id: @user.id, success: '2')
    
    @quest = Quest.find_by_id(@userquest.quest_id)
    # @questCondition = quest.condition
    # @questNeeds = quest.needs
  end
  
  def completeQuest  #퀘스트 포기와 성공 둘다 넣어 주겠습니다. 이름을 successQuest에서 completeQuest로 변경합니다
    @user = current_user
    @user.update(status: '2') #퀘스트가 완료되면 유저는 다시 퀘스트 미발급 상태(false)가 됩니다
  
  
    userquest = Userquest.find_by(user_id: @user.id, success: 2)
    userquest.update(success: 1)
    quest = Quest.find_by(userquest.quest_id)
    
    
    if quest.condition = "Photo"
    
    
    elsif quest.condition ="Array"
    #Array 퀘스트 성공 기록입니다.
    index = 1
    # arraydata =
    #   quest.needs.to_i.times do
    #   index.to_s + params[index]
    #   index += 1
    
    userquest.update(data: arraydata.to_s)
    
    
    else
    #Write 퀘스트 성공 기록입니다
    userquest.update(data: params[:writedata])
    end
    redirect_to '/makeQuest_success'
    # unless params[:quest_id].nil? #퀘스트를 성공하면 usersquest모델에 있는 유저의 퀘스트가 success : false에서 success : true로 바뀝니다.
    #   userquest = Userquest.find_by(user_id: @user.id, success: '2')
    #   userquest.update(success: '1')
      
    #   redirect_to '/makeQuest_success'  # 2: 퀘스트 발급, 1: 성공, 0:실패
    # else
    #   redirect_to '/makeQuest_failed'
    # end
    
  end
  
  
  def credit
      
  end
  
  def makeQuest_failed   #퀘스트실패시 사진
    
    @user = current_user
    userquest = Userquest.find_by(user_id: @user.id, success: '2')
    userquest.update(success: '0')
    
    @num = rand(6)+1
  end
  
  def makeQuest_success  #퀘스트성공시 사진
    @num = rand(5)+1
  end
  
  def my_page
    
    # #필터링
    jung = [1..8]
    ad = [9..21]
    ja = [22..32]
    tu = [33..35]
    hack = [36..40]
    
    if params[:theme] == '전체'
      @userquest_select = Userquest.where(user_id: current_user.id)
    elsif params[:theme]== '정'
      @userquest_select = Userquest.where(user_id: current_user.id, quest_id: jung)
    elsif params[:theme] == '모험'
      @userquest_select = Userquest.where(user_id: current_user.id, quest_id: ad)
    elsif params[:theme] == '해커톤'
      @userquest_select = Userquest.where(user_id: current_user.id, quest_id: hack)
    elsif params[:theme] == '자기계발'
      @userquest_select = Userquest.where(user_id: current_user.id, quest_id: ja)
    else 
      @userquest_select = Userquest.where(user_id: current_user.id, quest_id: ad)
    end
    #핕터링 끝
    
    
    if params[:icon_prefix]
      @userquest_all = Userquest.search(user_id, params[:icon_prefix])
    else 
      @userquest_all = Userquest.where(user_id: current_user.id)
    end
  end
  
  def my_bbs
    @userquests = Userquest.where(user_id: current_user.id).page(params[:page])
  end
  
  def index
       @user = current_user
       @quest = Quest.all
       @quest_size = Quest.all.size
  #  if @user.status == 1
  #     redirect_to '/makeQuest_quest'
  #  end
    time = Time.new
    time_day = time.day
    
    temp1 = (@user.id + time_day) % 8 + 1
    temp2 = temp1 % 13 + 9
    temp3 = (temp1 + 8) % 11 + 22
    temp4 = (temp1 + 21) % 3 + 33
    temp5 = (temp1 + 32) % 5 + 36
    
    @quest1 = Quest.find_by(id: temp1)
    @quest2 = Quest.find_by(id: temp2)
    @quest3 = Quest.find_by(id: temp3)
    @quest4 = Quest.find_by(id: temp4)
    @quest5 = Quest.find_by(id: temp5)
    
     @userquest = Userquest.find_by(user_id: @user.id, success: 0)
    @userquest_profile_success_size = Userquest.where(user_id: @user.id, success: true).size
     @userquest_profile_fail_size = Userquest.where(user_id: @user.id, success: false).size
     
     #사용자가 어떤 테마의 퀘스트를 많이 했을까요?
     userquest_for_max = Userquest.where(user_id: @user.id)
     
     for i in 0..(userquest_for_max.size - 1)
      jung = 0
      ja = 0
      hack = 0
      tu = 0
      adv = 0
      if userquest_for_max[i].quest.theme == "정"
        jung += 1
      elsif userquest_for_max[i].quest.theme == "자기계발"
        ja += 1
      elsif userquest_for_max[i].quest.theme == "해커톤"
        hack += 1
      elsif userquest_for_max[i].quest.theme == "튜토리얼"
        tu += 1
      else
        adv += 1
      end
     end
     
      arr = [ jung, ja, hack, tu, adv ]
      max = jung
      
      for j in 0..4
        for k in 0 .. 4
          if max < arr[k]
            max = arr[k]
          end
        end
      end
      
      if max == jung
        @theme = "정"
      elsif max == ja
        @theme = "자기계발"
      elsif max == hack
        @theme = "해커톤"
      elsif max == tu
        @theme = "튜토리얼"
      else
        @theme = "모험"
      end
      ####### 짜놓고 보니깐 극혐이네 되긴 돼요
  end
  
end
