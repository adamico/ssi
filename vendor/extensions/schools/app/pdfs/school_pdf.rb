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
      table(event_rows(events), column_widths: [40, 300, 200], header: true) do
        self.row_colors = ["FFFFFF", "DDDDDD"]
        header = row(0)
        body = rows(1..-1)

        header.font_style = :bold
        header.borders = [:bottom]
        header.columns(0..-1).borders = [:bottom]
        header.columns(0..-1).background_color = "FFFFFF"
        header.border_width = 1
        body.borders = []
        rows(-1).borders = [:bottom]
        titles = body.column(1)
        speakers = body.column(-1)
        speakers.style(font_style: :italic)
        titles.style(font_style: :bold)
        last_2_cols = body.columns(1..-1)
        body.each do |line|
          title = cells[line.row, 1]
          speaker = cells[line.row, 2]
          title.style(font_style: :italic) unless speaker.content.present?
        end
      end
    end
  end

  def event_rows(events)
    [["Time", "Event Title", "Speaker"]] +
    events.map do |event|
      [event.time, event.title.gsub(/<\/?[^>]*>/, ""), event.speaker]
    end
  end
end
