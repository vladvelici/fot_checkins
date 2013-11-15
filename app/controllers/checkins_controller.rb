class CheckinsController < ApplicationController
  before_filter :authenticate_comitee!

  before_action :set_checkin, only: [:show, :edit, :destroy]

  # GET /checkins
  # GET /checkins.json
  def index
    @checkins = Checkin.all
  end

  # GET /checkins/1
  # GET /checkins/1.json
  def show
  end

  # GET /checkins/new
  def new
    @today = Checkin.where(:date => Time.now.strftime("%Y-%m-%d")).count
    @checkin = Checkin.new
    @membr = nil
  end

  def batch
  end

  def process_batch
    date = params[:date]
    ids = params[:idlist]

    ids.strip!
    ids = ids.split("\n")
    @errors = {}

    ids.each { |id|
      id.strip!
      if id.length > 0
        x = Checkin.new({:studentid => id, :date => date})
        @errors[id] = x.errors.messages unless x.save
      end
    }

    respond_to do |format|
      if @errors.length == 0
        format.html { redirect_to checkin_path, notice: 'Everything worked properly. You can see the checkins below.' }
        format.json { redirect_to checkin_path, status: :created }
      else
        format.html {
          render action: 'batch'
        }
        format.json { render json: @errors, status: :unprocessable_entity }
      end
    end

  end

  # POST /checkins
  # POST /checkins.json
  def create
    @checkin = Checkin.new(checkin_params)

    unless (@checkin.valid?)
      if (params[:checkin][:m_email] != nil && params[:checkin][:m_email].length > 4 && params[:checkin][:m_paid] != nil)
        tmpMember = Member.find_by_studentid(@checkin.studentid)
        if tmpMember == nil
          tmpMember = Member.new({:studentid => @checkin.studentid})
        end
        tmpMember.name = params[:checkin][:m_name]
        tmpMember.email = params[:checkin][:m_email]
        tmpMember.paid = params[:checkin][:m_paid]
        tmpMember.save
      end
    end

    respond_to do |format|
      if @checkin.save
        format.html { redirect_to new_checkin_path, notice: 'Checkin was successfully created.' }
        format.json { render action: 'show', status: :created, location: @checkin }
      else
        format.html {
          @membr = Member.find_by_studentid(@checkin.studentid)
          if @membr == nil
            @membr = Member.new
          end
          render action: 'new'
        }
        format.json { render json: @checkin.errors, status: :unprocessable_entity }
      end
    end
  end


  # DELETE /checkins/1
  # DELETE /checkins/1.json
  def destroy
    @checkin.destroy
    respond_to do |format|
      format.html { redirect_to checkins_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_checkin
      @checkin = Checkin.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def checkin_params
      params.require(:checkin).permit(:studentid, :date, :m_name, :m_email, :m_paid)
    end
end
