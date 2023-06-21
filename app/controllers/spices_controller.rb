class SpicesController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
    wrap_parameters format: []

    def index 
        render json: Spice.all
    end

    def create
        spice = Spice.create(spices_params)
        render json: spice, status: 201
    end

    def update
        spice = find_spice
        spice.update(spices_params)
        render json: spice
    end

    def destroy
        spice = find_spice
        spice.destroy
        head :no_content
    end

    private

    def spices_params
        params.permit(:title, :image, :description, :notes, :rating)
    end

    def find_spice
        Spice.find(params[:id])
    end

    def render_not_found
        render json: {error: "Spice not found"}, status: 404
    end

end
