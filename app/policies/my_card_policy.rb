class MyCardPolicy < ApplicationPolicy
  def show?
    update?
  end

  def create?
    update?
  end

  def update?
    user.my_cards.include?(record) && !record.primary_changed?
  end

  def destroy?
    update? && !record.primary?
  end

  class Scope < Scope
    def resolve
      user.my_cards
    end
  end
end
