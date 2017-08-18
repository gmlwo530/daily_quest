class PhotocompleteController < ApplicationController
  def success
  end

  def fail
  end
  
  def check
    require 'aws-sdk-rails'

    image = Userquest.find(params[:id]).photoData.to_s
    quest = Userquest.find(params[:id]).quest_id.to_s
    @questneeds = Quest.find(quest).needs.to_s

    Aws.config.update({
       credentials: Aws::Credentials.new(ENV["AWS_Key"], ENV["AWS_Secret"]),
       region: "us-east-1"
    })

    # post = Post.find(params[:id]).image.to_s

    # str = "https://dailyquestbucket.s3.amazonaws.com/uploads/post/image/2/cutecat.jpg"
    strsplit = image.split('/',4)
    client = Aws::Rekognition::Client.new
    resp = client.detect_labels(
            image: {
              s3_object: {
                bucket: "dailyquestbucket", name: strsplit[3]
                }
              }
          )

    result = resp.labels.first[:name]
    
    if result == @questneeds
      redirect_to '/success'
    else
      
      redirect_to '/fail'
    end
end
