class AppointmentsController < ApplicationController
  def index
    @current_month = params[:month]&.to_i || Date.today.month
    @current_year = params[:year]&.to_i || Date.today.year
    
    @appointments = Appointment.for_month(@current_year, @current_month)
  end
  
  def create
    @appointment = Appointment.new(appointment_params)

    if @appointment.save
      respond_to do |format|
        format.html { redirect_to root_path, notice: "Agendamento realizado com sucesso!" }
        format.turbo_stream do
          render turbo_stream: turbo_stream.append("modals", partial: "appointments/success_modal", locals: { appointment: @appointment })
        end
      end
    else
      redirect_to root_path, alert: @appointment.errors.full_messages.join(", ")
    end
  end

  def destroy
    @appointment = Appointment.find_by(id: params[:id])
    if @appointment&.destroy
      redirect_to root_path, notice: "Agendamento cancelado com sucesso!"
    else
      redirect_to root_path, alert: "Não foi possível cancelar o agendamento."
    end
  end
  
  private
  
  def appointment_params
    params.require(:appointment).permit(:data, :nome, :telefone)
  end
end