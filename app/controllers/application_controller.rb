# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :reset_session

  before_action :authenticate_user!
  before_action :set_locale

  def set_locale
    I18n.locale = if current_user
                    current_user.locale || I18n.default_locale
                  else
                    I18n.default_locale
                  end
  end

  helper_method :change_locale

  def change_locale
    locale = params[:id]
    current_user.locale = locale
    respond_to do |format|
      if current_user.save
        format.html { redirect_to root_path , notice: t('locale_changed')}
      end
    end
  end
end