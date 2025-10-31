class AppointmentsController < ApplicationController
  def index
    @current_month = params[:month]&.to_i || Date.today.month
    @current_year = params[:year]&.to_i || Date.today.year
    
    @appointments = Appointment.for_month(@current_year, @current_month)
  end
  
  def create
    @appointment = Appointment.new(appointment_params)
    
    if @appointment.save
      redirect_to root_path, notice: "Agendamento realizado com sucesso!"
    else
      redirect_to root_path, alert: @appointment.errors.full_messages.join(", ")
    end
  end
  
  private
  
  def appointment_params
    params.require(:appointment).permit(:data, :nome, :telefone, :endereco)
  end
end