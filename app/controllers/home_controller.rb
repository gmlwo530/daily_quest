class HomeController < ApplicationController
  # before_action :authenticate_user!, :except => [:index]
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
    
    
    @userquest = Userquest.create(user_id: params[:user_id], quest_id: params[:quest_id], success: false)
    redirect_to '/makeQuest_quest'
  
  end

  def makeQuest_quest
   
    @user = current_user
    @userquest = Userquest.find_by(user_id: @user.id, success: false)
    
  end
  
  def completeQuest  #퀘스트 포기와 성공 둘다 넣어 주겠습니다. 이름을 successQuest에서 completeQuest로 변경합니다
    @user = current_user
    @user.update(status: false) #퀘스트가 완료되면 유저는 다시 퀘스트 미발급 상태(false)가 됩니다
    
    
    unless params[:user_id].nil? #퀘스트를 성공하면 usersquest모델에 있는 유저의 퀘스트가 success : false에서 success : true로 바뀝니다.
      userquest = Userquest.find_by(user_id: @user.id, success: false)
      userquest.update(success: true)
      
      redirect_to '/makeQuest_success'  # 이 방식의 문제점 : 예전에 실패한 퀘스트를 true로 바꿉니다. 해결법은 success의 상태를 true continue false 3개로 바꾸거나 다른 접근 방법을 찾아야 합니다 
    else
      userquest.update(success: false)
      redirect_to '/makeQuest_failed'
    end
  end
  
  
  def credit
      
  end
  
  def makeQuest_failed   #퀘스트실패시 사진
    @num = rand(6)+1
  end
  
  def makeQuest_success  #퀘스트성공시 사진
    @num = rand(5)+1
  end
  
  def my_page
    @userquests = Userquest.where(user_id: current_user.id).page(params[:page])
  end
  
  def my_bbs
    @userquests = Userquest.where(user_id: current_user.id).page(params[:page])
  end
end
