class SchoolPdf < Prawn::Document
  def initialize(school, view, events_days)
    super(top_margin: 70)
    @school = school
    @view = view
    @events_days = events_days
    page_header
    event_list
  end

  def page_header
    text @school.title, size: 24, style: :bold
    move_down 20
    text @school.theme, size: 24, style: :bold
    move_down 10
    text @school.when_and_where
  end

  def event_list
    @events_days.each do |day, events|
      move_down 10
      text day.strftime("%A %e"), style: :bold
      table event_rows(events) do
        self.row_colors = ["DDDDDD", "FFFFFF"]
      end
    end
  end

  def event_rows(events)
    [] +
    events.map do |event|
      [event.time, event.title.gsub(/<\/?[^>]*>/, "")]
    end
  end
end
