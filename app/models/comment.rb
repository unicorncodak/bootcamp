class Comment < ApplicationRecord
    belongs_to :CustomThread, optional: true
    belongs_to :user
end
