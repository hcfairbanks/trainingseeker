module SeatsHelper
  def display_seat(seat)
    display_str = "#{seat.full_name} | #{seat.email}"
    display_str += " | #{seat.phone}" unless seat.phone.blank?
    display_str
  end
 
  def mailer_display_seat(seat)
    components = [ seat.full_name, seat.email, seat.phone ]
    display_str = components.map do |c, idx|
      content_tag(:td) do
        c
      end
    end
    display_str.join.html_safe
  end

end
