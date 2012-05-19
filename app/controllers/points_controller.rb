class PointsController < ApplicationController
  before_filter :authenticate_user!
  
  # GET /points
  # GET /points.json
  def index
    @points = current_user.points

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @points }
    end
  end

  # GET /points/1
  # GET /points/1.json
  def show
    @point = current_user.points.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @point }
    end
  end

  # GET /points/new
  # GET /points/new.json
  def new
    @point = Point.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @point }
    end
  end

  # POST /points
  # POST /points.json
  def create
    previous_point = current_user.points.first
    @point = Point.new(params[:point])
    cumulative_value = previous_point.nil? ? @point.value : previous_point.cumulative_value + @point.value
    @point.cumulative_value = cumulative_value

    respond_to do |format|
      if @point.save
        current_user.points << @point
        format.html { redirect_to @point, notice: 'Point was successfully created.' }
        format.json { render json: @point, status: :created, location: @point }
      else
        format.html { render action: "new" }
        format.json { render json: @point.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /points/1
  # DELETE /points/1.json
  def destroy
    @point = Point.find(params[:id])
    @point.destroy

    respond_to do |format|
      format.html { redirect_to points_url }
      format.json { head :no_content }
    end
  end
end
