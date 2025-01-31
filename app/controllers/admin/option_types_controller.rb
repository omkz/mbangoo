module Admin
  class OptionTypesController < BaseController
    layout "admin"
    before_action :set_option_type, only: %i[show edit update destroy]
    def index
      @option_types = OptionType.all
    end

    def new
      @option_type = OptionType.new
    end

    def edit
    end

    def show
      @option_value = OptionValue.new
      @option_values = OptionValue.where(option_type_id: @option_type.id)
    end

    def destroy
      @option_type.destroy!

      respond_to do |format|
        format.html { redirect_to admin_option_types_path, status: :see_other, notice: "option type was successfully destroyed." }
        format.turbo_stream
      end
    end

    def create
      @option_type = OptionType.new(option_type_params)

      respond_to do |format|
        if @option_type.save
          format.html { redirect_to admin_option_types_path, notice: "option was successfully created." }
          format.turbo_stream
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @option_type.errors, status: :unprocessable_entity }
        end
      end
    end

    private

    def set_option_type
      @option_type = OptionType.find(params[:id])
    end

    def option_type_params()
      params.require(:option_type).permit(:name)
    end
  end
end