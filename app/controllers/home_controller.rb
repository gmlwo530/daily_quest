class HomeController < ApplicationController

  def makeQuest_new
    @user = current_user
    
    @quest1 = Quest.where(theme: '정').sample
    @quest2 = Quest.where(theme: '자기계발').sample
    @quest3 = Quest.where(theme: '모험').sample
    @quest4 = Quest.where(theme: '튜토리얼').sample
    @quest5 = Quest.where(theme: '해커톤').sample
    
  end
  
  def selectQuest   # makeQeust_user창에서 퀘스트를 발급 받으면 사용자와 퀘스트 간에의 관계를 묶어 주는 메소드입
    @user = current_user
    
    @userquest = Userquest.create(user_id: params[:user_id], quest_id: params[:quest_id], status: "selected")
    redirect_to '/makeQuest_quest'
  
  end

  def makeQuest_quest
    
    @userquest = Userquest.find_by(status: "selected")
    
  end
  
  
  def credit
      
  end
end
