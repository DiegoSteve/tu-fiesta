class ReportsController < ApplicationController
    before_action :set_event

    def event_report
      respond_to do |format|
        format.html
        format.pdf do
          if @event
            render pdf: 'event_report', layout: 'pdf.html.erb'
          else
            # Manejar el caso cuando no se encuentra el evento
            # Puedes redirigir a una página de error o hacer algo más según tus necesidades
            render pdf: 'event_not_found', layout: 'pdf.html.erb'
          end
        end
      end
    end
  
    private
  
    def set_event
      @event = Event.find_by(id: params[:id])
    end
end
