class User < ActiveRecord::Base
	has_many :sugangs
  has_many :taking_lectures, {through: :sugangs, source: :lecture}, -> { where(status: 'taking') }
  has_many :timetables

  validates :sid, uniqueness: true
  after_save :crawl_lectures, if: :sid_changed?

  #User.first.taking_lectures << Lecture.first
  # then taking kkul
  def self.from_omniauth(auth)
  	where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
	    user.provider = auth.provider
	    user.uid = auth.uid
	    user.name = auth.info.name
	    user.oauth_token = auth.credentials.token
	    user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
	  end
	end

  def color
    '#' + id.hash.abs.to_s(16)[0,6]
  end

  def crawl_lectures
    taking_lectures.clear
    #for this semester
    payload = <<PAYLOAD
<?xml version="1.0" encoding=http://haksa.ajou.ac.kr/uni/uni/cour/tlsn/findCourPersonalTakingLessonAply.action"utf-8"?>
<root>
<params>
<param id="strYy" type="STRING">2014</param>
<param id="strShtmCd" type="STRING">U0002001</param>
<param id="strStdNo" type="STRING">#{sid}</param>
<param id="admin" type="STRING">admin</param>
<param id="AUuser.taking_lectures.create lid: array_id[i], name: array_name[i], time: array_time[i], credit: array_credit[i]     DIT9_ID" type="STRING"></param>
</params>
</root>
PAYLOAD
    # Rails.logger.info payload

    res = RestClient.post "http://haksa.ajou.ac.kr/uni/uni/cour/tlsn/findCourPersonalTakingLessonAply.action", payload, 
      :content_type => 'text/xml/SosFlexMobile;charset=utf-8'
      # :cookies => {PHAROS_VISITOR:'0000000001438fc7dae21310ca1e000f',Lib1Proxy2Ssn:'84686512' ,SSOGlobalLogouturl:'get^http://portal.ajou.ac.kr/com/sso/logout.jsp$', ssotoken:'tEk5WjTshDwsdHpdG1eCmjC4p9q%2Bh8TULRvM3zihMZhYhEwT9YYlG5lwMsgzRzlixqBp%2B06JR4MqyPxrx0c%2FEUbFjgiES3Ss90wIxdN6QYQLKnVO956ZfBu9gW5OAZDj3qgVTGZgBUXcpN0Q6MwBFw%3D%3D', JSESSIONID:'vKeZyEucqSOpwfpnHg47AXfXR6xpYhJbYh63amQgjBgIGAbDSR2Joe6YgynmJ88K.hakdang_servlet_engine1'}


    doc= Nokogiri::XML(res)
    doc.remove_namespaces!
    lecture_name = doc.css('sbjtKorNm').children
    lecture_time = doc.css('ltTmNm').children
    lecture_id = doc.css('tlsnNo').children
    lecture_credit = doc.css('tm').children

    array_name = Array.new
    array_time = Array.new
    array_id = Array.new
    array_credit = Array.new

    for data in lecture_name
      array_name <<data.to_s
    end
    for data2 in lecture_time
      array_time <<data2.to_s
    end
    for data3 in lecture_id
      array_id <<data3.to_s
    end
    for data4 in lecture_credit
      array_credit <<data4.to_s
    end
    # Rails.logger.info array_name.length
    
    if array_name.length != 0
      for i in 0...array_name.length
        unless taking_lectures.where(lid: array_id[i]).exists?
          unless lecture = Lecture.find_by_lid(array_id[i])
            lecture = Lecture.create lid: array_id[i], name: array_name[i], time: array_time[i], credit: array_credit[i]
          end
          taking_lectures << lecture
        end
       end
    end

    # Rails.logger.info array_name
    # Rails.logger.info array_time
    # Rails.logger.info array_id
  end
end
