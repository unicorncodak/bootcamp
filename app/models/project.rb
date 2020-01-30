class Project < ApplicationRecord
    belongs_to :user
    has_many_attached :file
    has_many :CustomThreads, dependent: :destroy
    has_many :Teams, dependent: :destroy
    has_many :Tasks, dependent: :destroy

    validates :title, presence:true
    validates :description, presence:true
end
