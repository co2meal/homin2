module TimetableHelper
  def timeslices_from_lecture(lecture) 
    lecture.time.split(/\([^\)]*\)/).map(&:strip).map {|str| [str[0],str[1,str.length]] }
  rescue Exception => e
    raise lecture.inspect
  end

  def css_from_timeslice(timeslice)
    css = ""
    css += "left: " + case timeslice[0]
    when '월'
      "0%"
    when '화'
      "20%"
    when '수'
      "40%"
    when '목'
      "60%"
    when '금'
      "80%"
    end + ";"

    css += "width: 20%;"


    top, bottom2 = case timeslice[1]
    when /^\d\d:\d\d~\d\d:\d\d$/
      timeslice[1].split('~').map{|t| q = t.split(':'); (q[0].to_i-9)*100/9.0+q[1].to_i*100/9.0/60 }
    when /^[ABCDEF]$/
      [(timeslice[1].ord - "A".ord) * 100 / 6.0, (timeslice[1].ord - "A".ord + 1) * 100 / 6.0]
    when /^[1234567890]+$/
      [(timeslice[1].to_i - 1) * 100 / 9.0, timeslice[1].to_i * 100 / 9.0]
    else
      raise timeslice[1]
    end
    bottom = 100 - bottom2


    css += "top: #{top}%; bottom: #{bottom}%;"

    css
  end
end
