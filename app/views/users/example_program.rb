s = "00:01:07,400-234-090
     00:05:01,701-080-080
     00:05:00,400-234-090"
def solution(s)
  unless s.empty?
    s = s.gsub("\n", " ") #remove new line and add whitespace
    call_logs = {}
    array_of_call_logs = s.split(" ")
    array_of_call_logs.each do |log|
      call_record = log.split(",")
      call_duration = call_record.first #get duration
      cell_number = call_record[1] # get mobile number
      call_logs[cell_number] = [] << call_duration
    end 
    call_logs.keys.each do |uniq_cell_record|
      call_logs[:uniq_cell_record].each do |duration|
        in_time =  duration.split(":").map(&:to_i)
        total_duration = { hour: in_time.first, minute: in_time[1], second: in_time[2] }
        if total_duration[:minute] < 5 && total_duration[:hour] == 0
          total_time = convert_minute_into_second(total_duration[:minute]) + total_duration[:second]
          charges = get_second_pulse_charges(total_time)
          call_logs[cell_number] = [] << total_time 
        elsif total_duration[:minute] >= 5
          unless total_duration[:second] == 0
            total_time = convert_hour_into_minute + (total_duration[:minute] + 1)
          end
          total_time = convert_hour_into_minute + total_duration[:minute]
          charges = get_minute_pulse_charges(total_time)
          call_logs[cell_number] = [] << convert_minute_into_second(total_time)
        end
      end
    end 
  end
  total_charges =[]
  call_logs.keys.each do |uniq_cell_record|
    total_charges << call_logs[uniq_cell_record].inject(&:+)
  end
  total_bill = total_charges - total_charges.sort[-1] # removing highest call duration 
  total_bill.inject(&:+)#return final bill
end
 

private

def convert_minute_into_second(minute)
 minute * 60
end

def convert_hour_into_minute(hour)
 hour * 60
end

def get_second_pulse_charges(total_time)
 total_time * 3
end

def get_minute_pulse_charges(total_time)
 total_time * 150
end