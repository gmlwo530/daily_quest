class HomeController < ApplicationController

  def makeQuest_new
    @user = current_user
    
    @quest1 = Quest.where(category: 'cat1').sample
    @quest2 = Quest.where(category: 'cat2').sample
    @quest3 = Quest.where(category: 'cat3').sample
    @quest4 = Quest.where(category: 'cat4').sample
    @quest5 = Quest.where(category: 'cat5').sample
    
  end
  
  def selectQuest   # makeQeust_user창에서 퀘스트를 발급 받으면 사용자와 퀘스트 간에의 관계를 묶어 주는 메소드입
    @userquest = Userquest.create(user_id: params[:quest_id], quest_id: params[:quest_id], status: "selected")
    redirect_to '/makeQuest_quest'
  
  end

  def makeQuest_quest
    current_user=1
    @quest = Userquest.where(category: current_user)
    
  end
  
  
  def credit
      
  end
end
