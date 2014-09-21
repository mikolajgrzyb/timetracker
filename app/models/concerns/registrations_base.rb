module RegistrationsBase
  extend ActiveSupport::Concern

  included do
    include ActiveModel::Model
    attr_accessor :company_name,
                  :email,
                  :first_name,
                  :last_name,
                  :tos_accepted,
                  :password,
                  :password_confirmation,
                  :user,
                  :account,
                  :token,
                  :persisted  
  end
end