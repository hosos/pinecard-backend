class ContactRequestPolicy < ApplicationPolicy
  def create?
    user.my_cards.include?(record.owner_card)
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
