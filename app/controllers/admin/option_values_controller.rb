module Admin
  class OptionValuesController < BaseController
    layout "admin"
    before_action :set_option_type, only: %i[show edit update destroy]
    def index
    end

    def new
    end

    def edit
    end

    def show
    end

    def create
      @option_type = OptionType.find(params[:option_value][:option_type_id])
      @option_value = @option_type.option_values.build(option_value_params)

      respond_to do |format|
        if @option_value.save
          format.html { redirect_to admin_option_type_path(@option_value.option_type_id), notice: "option value was successfully created." }
          format.json { render :show, status: :created, location: @option_value }
        else
          format.html { render "admin/option_types/show", status: :unprocessable_entity }
          format.json { render json: @option_value.errors, status: :unprocessable_entity }
        end
      end
    end

    def update
      respond_to do |format|
        if @option_value.update(option_params)
          format.html { redirect_to @option_value, notice: "option was successfully updated." }
          format.json { render :show, status: :ok, location: @option_value }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @option_value.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @option_value.destroy!

      respond_to do |format|
        format.html { redirect_to option_values_path, status: :see_other, notice: "option value was successfully destroyed." }
        format.turbo_stream
      end
    end

    private

    def set_option_type
      @option_value = OptionValue.find(params[:id])
    end

    def option_value_params()
      params.require(:option_value).permit(:value, :option_type_id)
    end
  end
end